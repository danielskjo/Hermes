import 'package:flutter/material.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../models/chat.dart';
import '../../widgets/student/chat_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Messages',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
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

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          searchBar,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
    );
  }
}
