import 'package:flutter/material.dart';
import '../../models/message_model.dart';

class NewMessageRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "New Message Requests",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  IconButton(
                      icon: Icon(Icons.more_horiz),
                      iconSize: 30.0,
                      color: Colors.blueGrey,
                      onPressed: () {})
                ]),
          ),
          Container(
              height: 105,
              //color: Colors.blue,
              child: ListView.builder(
                padding: const EdgeInsets.only(right: 15),
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.account_circle_outlined, size: 60),
                        SizedBox(height: 6.0),
                        Text(
                          favorites[index].name,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
