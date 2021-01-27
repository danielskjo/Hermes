import 'package:flutter/material.dart';

class DonorChats extends StatefulWidget {
  static const routeName = '/donor-chats';

  @override
  _DonorChatsState createState() => _DonorChatsState();
}

class _DonorChatsState extends State<DonorChats> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
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
