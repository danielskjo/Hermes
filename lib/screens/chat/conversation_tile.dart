import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'conversation_screen.dart';

class ConversationTile extends StatelessWidget {

  DocumentSnapshot documentSnapshot;

  ConversationTile({this.documentSnapshot});

  String GetRecipient() {
    String chatRoomId = documentSnapshot.id;
    return chatRoomId.replaceAll(Constants.myUserName, "").replaceAll("_", "");
  }

  String GetDate() {
    Timestamp timestamp = documentSnapshot['lastMessageTimeStamp'];
    DateTime date = timestamp.toDate();
    String month = date.month.toString();
    String day = date.day.toString();
    String year = date.year.toString();

    return month + '/' + day + '/' +  year;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId: documentSnapshot.id,
            chatWithUserName: GetRecipient(),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        // margin: EdgeInsets.only(top: 5, bottom: 5, ),
        decoration: BoxDecoration(
          color: Color(0xFFE0F7FA),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
            Column(
              children: <Widget>[
                Text(
                  GetDate(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
