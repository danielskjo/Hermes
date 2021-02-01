import 'package:flutter/material.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../models/chat.dart';
import '../../widgets/chat_widget.dart';
import '../../widgets/search.dart';

class StudentChats extends StatefulWidget {
  static const routeName = '/student-chats';

  @override
  _StudentChatsState createState() => _StudentChatsState();
}

class _StudentChatsState extends State<StudentChats> {

  final List<Chat> messages = [
    Chat(DateTime.now().toString(), 'Lydia Yang', 'I want chicken.',
        DateTime.now()),
    Chat(DateTime.now().toString(), 'Brenden Smith',
        'Playing Destiny 2 right now!', DateTime.now()),
  ];

  void _deleteConversation() {}

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
