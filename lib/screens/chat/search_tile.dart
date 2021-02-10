import 'package:csulb_dsc_2021/screens/chat/conversation_screen.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  /// create chatroom, send user to conversation screen, pushreplacement
  sendMessage(String userName, BuildContext context) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

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
        ),
      ),
    );
  }

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
              print('pressed message icon');
              sendMessage(userName, context);
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
