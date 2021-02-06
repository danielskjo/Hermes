import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
              children: [
                Text(userName, style: TextStyle(color: Colors.black),),
                Text(userEmail, style: TextStyle(color: Colors.black),),
              ]
          ),
          Spacer(),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            icon: Icon(Icons.message),
            onPressed: () {
              print('pressed message icon');
            },
          ),
        ],
      ),
    );
  }
}