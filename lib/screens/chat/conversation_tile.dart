import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class ConversationTile extends StatelessWidget {

  DocumentSnapshot documentSnapshot;

  ConversationTile({this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId: documentSnapshot.id,
            chatWithUserName: 'getusername',
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 20),
        margin: EdgeInsets.only(top: 5, bottom: 5, right: 20),
        decoration: BoxDecoration(
          color: Color(0xFFE0F7FA),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            /// TODO: Have a CircleAvatar widget for
            /// displaying the image url of the person
            /// the current user is communicating with
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentSnapshot['lastMessageSentBy'],
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width *
                      0.45,
                  child: Text(
                    documentSnapshot['lastMessage'],
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
