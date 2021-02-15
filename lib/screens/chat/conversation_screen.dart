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
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatMessageTile(message: ds['message'], sentByMe: true,);
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
    await DatabaseService()
        .getConversationMessages(widget.chatRoomId)
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
      appBar: AppBar(elevation: 0.0, title: Text(widget.chatWithUserName)),
      body: Container(
        child: Stack(
          children: [
            /// List of Conversation Messages
            chatMessages(),
            /// Send Message Container
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
