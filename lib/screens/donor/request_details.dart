import 'package:csulb_dsc_2021/services/database.dart';
import 'package:flutter/material.dart';

class RequestDetails extends StatefulWidget {
  static const routeName = '/request-details';

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text(
          "Request Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white // add custom icons also
              ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.white,
                size: 26.0,
              ),
              onPressed: () {
                // Message student
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.blue,
                          // backgroundImage: NetworkImage(),
                          // backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Username",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text('Title'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text('Description'),
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
