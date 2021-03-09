import 'package:csulb_dsc_2021/screens/chat/conversation_screen.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';
// modal packages
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';



class SearchResultsTile extends StatefulWidget {
  final String userName;
  final String userEmail;
  final int index;

  SearchResultsTile({this.userName, this.userEmail, this.index});

  @override
  _SearchResultsTileState createState() => _SearchResultsTileState();
}

class _SearchResultsTileState extends State<SearchResultsTile> {
  sendMessage(String userName, BuildContext context) {

    print("Sending message, myName = " + "${Constants.myUserName}");

    /// Set the chat room fields to be used for the database
    List<String> users = [Constants.myUserName, userName];

    String chatRoomId = getChatRoomId(Constants.myUserName, userName);

    Map<String, dynamic> chatRoomData = {
      "users": users,
      "chat_room_id": chatRoomId,
    };

    /// Create the chat room in the database
    DatabaseService().createChatRoom(
      chatRoomData: chatRoomData,
      chatRoomId: chatRoomId,
    );

    /// Route the user over to the converstation screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId,
            chatWithUserName: userName,
          ),
        ),
    );
  }

  /// retreive a unique chat room id
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.userName, style: simpleTextStyle()),
            Text(widget.userEmail, style: simpleTextStyle()),
          ]),
          Spacer(),

          /// Send Message Icon Button
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            icon: Icon(Icons.message),
            onPressed: () {
              /// Send a message if the current user is not
              /// trying to message themselves
              if (widget.userName != Constants.myUserName) {
                sendMessage(widget.userName, context);
              } else {
                /// TODO: Implement a snackbar to display the message
                print('Cant send message to the same user');
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //       duration: Duration(milliseconds: 2500),
                //       content: Text('Cannot send a message to the same user'),
                //   ),
                // );
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Text('My modal bottom sheet'),
                  ),
                );
              }
            },
            iconSize: 28,
          ),
        ],
      ),
    );
  }
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 18,
  );
}
