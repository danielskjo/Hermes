// Flutter Packages
import 'package:flutter/material.dart';

// Screens
import './conversation_screen.dart';

// Services
import '../../services/database.dart';
import '../../services/helper/constants.dart';

// Widgets
import '../../widgets/helper_widgets.dart';

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
      decoration: HelperWidgets().GetGreyBottomBorder(),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.userName,
              style: simpleTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              widget.userEmail,
              style: simpleTextStyle(fontSize: 15, fontWeight: null),
            ),
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
                showDialog(
                  context: context,
                  builder: (ctx) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: AlertDialog(
                      title: Text(
                        'Cannot send a message to the same user',
                      ),
                      titleTextStyle: simpleTextStyle(
                        fontSize: 15,
                        fontWeight: null,
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
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

TextStyle simpleTextStyle({double fontSize, FontWeight fontWeight}) {
  return TextStyle(
    color: Colors.black,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
