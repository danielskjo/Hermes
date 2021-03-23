// Flutter Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Screens
import 'conversation_screen.dart';

// Services
import '../../services/helper/constants.dart';

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

    return DateFormat.yMMMd().format(date);
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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey[300],
            ),
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
                      GetRecipient(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      child: Text(
                        (documentSnapshot['lastMessage'].length > 45)
                        ? '${documentSnapshot['lastMessage'].substring(0, 45)}...'
                        : documentSnapshot['lastMessage'],
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
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
