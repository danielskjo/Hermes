import 'package:csulb_dsc_2021/widgets/graphics.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, title: Text('My Messages')),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: _usernameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search username...",
                        ),
                      ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print("tapped search");
                      },
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
