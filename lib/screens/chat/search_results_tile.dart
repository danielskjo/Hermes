import 'package:csulb_dsc_2021/screens/chat/conversation_screen.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';

class SearchResultsTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchResultsTile({this.userName, this.userEmail});

  sendMessage(String userName, BuildContext context) {

    print("Sending message, myName = " + "${Constants.myUserName}");
    List<String> users = [Constants.myUserName, userName];

    String chatRoomId = getChatRoomId(Constants.myUserName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chat_room_id": chatRoomId,
    };

    DatabaseService().createChatRoom(chatRoom, chatRoomId);

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
            Text(userName, style: simpleTextStyle()),
            Text(userEmail, style: simpleTextStyle()),
          ]),
          Spacer(),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            icon: Icon(Icons.message),
            onPressed: () {
              if(userName != Constants.myUserName) {
                sendMessage(userName, context);
              } else {
                /// TODO: Implement a snackbar to display the message
                print('Cant send message to the same user');
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
