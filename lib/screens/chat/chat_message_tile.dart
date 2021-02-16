import 'package:flutter/material.dart';

class ChatMessageTile extends StatelessWidget {
  String message;
  bool sentByMe;

  ChatMessageTile({this.message, this.sentByMe});

  TextStyle GetStyle() {
    return sentByMe
        ? TextStyle(color: Colors.white)
        : TextStyle(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      /// align messages sent by the current user to the right
      mainAxisAlignment:
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomRight:
                    sentByMe ? Radius.circular(0) : Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: sentByMe ? Radius.circular(24) : Radius.circular(0),
              ),
              color: sentByMe ? Colors.blue : Colors.grey[300],
            ),
            padding: EdgeInsets.all(16),
            child: Text(message, style: GetStyle()),
          ),
        ),
      ],
    );
  }

}
