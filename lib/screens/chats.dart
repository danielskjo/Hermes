import 'package:flutter/material.dart';

// Widgets
import '../widgets/graphics.dart';
import '../models/chat.dart';
import '../widgets/chat_constructor.dart';
import '../widgets/search.dart';
import '../widgets/student/new_message_requests.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final List<Chat> messages = [
    Chat(DateTime.now().toString(), 'Lydia Yang', 'I want chicken.',
        DateTime.now()),
    Chat(DateTime.now().toString(), 'Brenden Smith',
        'Playing Destiny 2 right now!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Daniel Jo',
        'I am writing Firebase right now', DateTime.now()),
    Chat(DateTime.now().toString(), 'Kevin Jay Patel',
        'Come to the DSC zoom meeting!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Grim Reaper', 'Knock knock',
        DateTime.now()),
    Chat(DateTime.now().toString(), 'Eren Jaegar',
        'I\'m gonna join the Scout Regiment!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Armin Arlet',
        'I\'m very sad I am getting beat up', DateTime.now()),
    Chat(DateTime.now().toString(), 'Mikasa Ackerman', 'Where is Eren',
        DateTime.now()),
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
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      elevation: 0.0,
      title: Text(
        'My Messages',
        // style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context,
              delegate: Search.chats(_deleteConversation, messages)),
        ),
      ],
    );

    // final Padding searchBar = Padding(
    //   padding: EdgeInsets.only(top: 16, left: 16, right: 16),
    //   child: TextField(
    //     decoration: InputDecoration(
    //       hintText: "Search...",
    //       hintStyle: TextStyle(color: Colors.grey.shade600),
    //       prefixIcon: Icon(
    //         Icons.search,
    //         color: Colors.grey.shade600,
    //         size: 20,
    //       ),
    //       filled: true,
    //       fillColor: Colors.grey.shade100,
    //       contentPadding: EdgeInsets.all(8),
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(20),
    //           borderSide: BorderSide(color: Colors.grey.shade100)),
    //     ),
    //   ),
    // );

    // final Container body = Container(
    //   height: 90.0,
    //   child: CategorySelector(),
    // );

    final Container messageList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(child: ChatWidget(messages, _deleteConversation, false)),
    );

    final Container favoriteContacts = Container(
      height: 174,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[300],
          ),
        ),
      ),
      child: NewMessageRequests(),
    );

    final pageBody = Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Column(
            children: <Widget>[
              favoriteContacts,
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: messageList,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
