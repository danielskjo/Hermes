import 'package:csulb_dsc_2021/screens/chat/home_body.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:csulb_dsc_2021/services/helper/helperFunctions.dart';
import 'package:flutter/material.dart';

// Widgets
import '../../widgets/graphics.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      elevation: 0.0,
      title: Text('My Messages'),
    );

    return Scaffold(
      appBar: appBar,
      body: ChatHomeBody(appBarHeight: appBar.preferredSize.height,),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
