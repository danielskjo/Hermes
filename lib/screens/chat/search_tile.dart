import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: simpleTextStyle()),
                Text(userEmail, style: simpleTextStyle()),
              ]
          ),
          Spacer(),
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            icon: Icon(Icons.message),
            onPressed: () {
              print('pressed message icon');
            },
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  TextStyle simpleTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 18,
    );
  }
}