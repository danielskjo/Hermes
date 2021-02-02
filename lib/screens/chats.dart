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

    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Messages',
      ),
      actions: <Widget>[
        IconButton( // Search icon
          icon: Icon(Icons.search),
          onPressed: () => showSearch(context: context, delegate: Search.chats( _deleteConversation, messages)),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );

    final chatListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.9,
      child: ChatWidget(messages, _deleteConversation, false),
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          chatListWidget,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
    );
  }
}
