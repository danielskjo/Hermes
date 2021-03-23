// Flutter Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Screens
import './send_message_tile.dart';

// Services
import '../../services/database.dart';
import '../../services/helper/constants.dart';

// Widgets
import '../../widgets/loading.dart';

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
                    sentByMe:
                        Constants.myUserName == documentSnapshot['sentBy'],
                  );
                })
            : Loading();
      },
    );
  }

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      String message = messageEditingController.text;

      /// TODO: Find out how to get current data and time in PCT
      DateTime messageTimeStamp = DateTime.now();

      Map<String, dynamic> chatMessageMap = {
        "message": message,
        "sentBy": Constants.myUserName,
        "time-stamp": messageTimeStamp,
      };

      DatabaseService()
          .addMessage(widget.chatRoomId, chatMessageMap)
          .then((value) {
        UpdateLastMessageSent(message, messageTimeStamp);
      });
    } else {
      print('Input text is empty');
    }
  }

  UpdateLastMessageSent(String message, DateTime messageTimeStamp) {
    Map<String, dynamic> lastMessageInfoMap = {
      "lastMessage": message,
      "lastMessageSentBy": Constants.myUserName,
      "lastMessageTimeStamp": messageTimeStamp,
    };

    DatabaseService().updateLastMessageSent(
      chatRoomId: widget.chatRoomId,
      lastMessageInfoMap: lastMessageInfoMap,
    );

    setState(() {
      messageEditingController.text = '';
    });
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
      appBar: AppBar(title: Text(widget.chatWithUserName),),
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
