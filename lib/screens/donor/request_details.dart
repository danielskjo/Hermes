import 'package:csulb_dsc_2021/screens/chat/conversation_screen.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

class RequestDetails extends StatefulWidget {
  static const routeName = '/request-details';

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  String requestId;
  dynamic request;

  String username;
  String imageUrl;

  String title;
  String desc;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  /// TODO: Find a way to use the 'send message' function in the
  /// Search Results Tile class in screens/chat (redunant code usage)
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
  void didChangeDependencies() async {
    requestId = ModalRoute.of(context).settings.arguments as String;
    request = await DatabaseService().getRequestData(requestId);

    setState(() {
      _titleController.text = request.get(FieldPath(['title']));
      _titleController.text != null ? _titleController.text : 'Title';
      _descController.text = request.get(FieldPath(['desc']));
      _descController.text != null ? _descController.text : 'Description';
      username = request.get(FieldPath(['username']));
      imageUrl = request.get(FieldPath(['imageUrl']));
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text(
          "Request Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // add custom icons also
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.white,
                size: 26.0,
              ),
              onPressed: () {
                // Message student
                print('current user: ' + Constants.myUserName);
                print('sending a message to: ' + username);
                sendMessage(username, context);
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        imageUrl != null
                            ? Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(imageUrl),
                                  ),
                                ),
                              )
                            : Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage('assets/img/default.jpg')),
                                ),
                              ),
                        SizedBox(width: 10),
                        Text(
                          username != null ? username : 'Username',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: TextFormField(
                      decoration:
                        InputDecoration(hintText: "Title"),
                      controller: _titleController,
                      enabled: false,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextFormField(
                      decoration:
                        InputDecoration.collapsed(hintText: "Description"),
                      maxLines: null,
                      controller: _descController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
