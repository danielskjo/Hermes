import 'package:csulb_dsc_2021/widgets/favorite_contacts.dart';
import 'package:flutter/material.dart';

// Widgets
import '../widgets/graphics.dart';
import '../models/chat.dart';
import '../widgets/chat_constructor.dart';
import '../widgets/search.dart';

class Chats extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final List<Chat> messages = [
    Chat(DateTime.now().toString(), 'Lydia Yang', 'I want chicken.',
        DateTime.now()),
    Chat(DateTime.now().toString(), 'Brenden Smith',
        'Playing Destiny 2 right now!', DateTime.now()),
  ];

  void _deleteConversation(String id) {
    setState(() {
      messages.removeWhere((request) {
        return request.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      elevation: 0.0,
      title: Text(
        'My Messages',
        style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatBox()),
            );*/
          },
        ),
      ],
    );

    final Padding searchBar = Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade100)),
        ),
      ),
    );

    final Container body = Container(
      height: 90.0,
      child: CategorySelector(),
    );

    final Container messageList = Container(
      height: 580.0,
      child: Column(
        children: <Widget>[
          FavoriteContacts(),
          RecentChats(),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))),
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //searchBar,
          body,
          messageList,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
