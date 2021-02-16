import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/chat_message_tile.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatWithUserName;
  final String chatRoomId;

  ConversationScreen({this.chatRoomId, this.chatWithUserName});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  // final String myUserName, myEmail;

  getInfoFromSharedPreference() {}

  /// stream is used for sending and viewing messages in real-time
  Stream messageStream;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data.docs.length,
                /// displays the most recent messages
                reverse: true,
                itemBuilder: (context, index) {
                  /// retrieve message from database in the form of documentSnapshot
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return ChatMessageTile(
                    message: documentSnapshot['message'],
                    sentByMe: Constants.myName == documentSnapshot['sentBy'],
                  );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      DateTime lastMessageTimeStamp = DateTime.now();

      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sentBy": Constants.myName,
        "time-stamp": lastMessageTimeStamp,
      };

      DatabaseService().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = '';
      });
    } else {
      print('Input text is empty');
    }
  }

  getAndSetMessages() async {
    await DatabaseService().getConversationMessages(widget.chatRoomId)

        /// after conversation messages are received
        .then((value) {
      /// rebuild the ui to reflect the message stream
      setState(() {
        messageStream = value;
      });
    });

    print('messageStream val: ' + messageStream.toString());
  }

  @override
  void initState() {
    getAndSetMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// display username that current user is communicating with at the app bar
      appBar: AppBar(title: Text(widget.chatWithUserName)),
      body: Container(
        child: Stack(
          children: [
            /// List of Conversation Messages
            chatMessages(),
            /// Send Message Container
            Container(
              alignment: Alignment.bottomCenter,
              // width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        /// when the user hits 'enter', a message will send
                        onEditingComplete: () {
                          sendMessage();
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
