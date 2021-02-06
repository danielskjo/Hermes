import 'package:csulb_dsc_2021/screens/chat/search_users.dart';
import 'package:csulb_dsc_2021/widgets/search.dart';
import 'package:flutter/material.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../models/chat.dart';
import '../../widgets/chat/chat_constructor.dart';


class ChatRoom extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  final List<Chat> messages = [
    Chat(DateTime.now().toString(), 'Lydia Yang', 'I want chicken.',
        DateTime.now()),
    Chat(DateTime.now().toString(), 'Brenden Smith',
        'Playing Destiny 2 right now!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Daniel Jo',
        'I am writing Firebase right now', DateTime.now()),
    Chat(DateTime.now().toString(), 'Kevin Jay Patel',
        'Come to the DSC zoom meeting!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Grim Reaper',
        'Knock knock', DateTime.now()),
    Chat(DateTime.now().toString(), 'Eren Jaegar',
        'I\'m gonna join the Scout Regiment!', DateTime.now()),
    Chat(DateTime.now().toString(), 'Armin Arlet',
        'I\'m very sad I am getting beat up', DateTime.now()),
    Chat(DateTime.now().toString(), 'Mikasa Ackerman',
        'Where is Eren', DateTime.now()),
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
      title: Text('My Messages'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context,
              delegate: SearchUsers()),
        ),
      ],
    );


    final Container messageList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(child: ChatWidget(messages, _deleteConversation, false)),
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
            children: <Widget> [
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
