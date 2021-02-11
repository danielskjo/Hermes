import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/student/new_request.dart';
import 'package:csulb_dsc_2021/screens/student/edit_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Models
import '../../models/request.dart';

// Cards
import '../../widgets/cards/request_card.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/search.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<Request> _requests = [];
  
  String uid;
  QuerySnapshot requests;

  @override
  void initState() {
    super.initState();
    fetchUserID();
    fetchUsersRequests(uid);
  }

  fetchUserID() {
    uid = FirebaseAuth.instance.currentUser.uid;
  }

  fetchUsersRequests(String uid) {
    DatabaseService().getUsersRequestsData(uid).then((results) {
      setState(() {
        requests = results;
        print(requests.runtimeType);
      });
    });
  }

  // After request is created
  void requestReciept() {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Container(
            // height: 20,
            child: Row(children: <Widget>[
          Text("New request created. "),
          Ink(
            child: InkWell(
              child: Text(
                "View request",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {},
            ),
          )
        ])),
        duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Requests',
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          // Search icon
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context, delegate: Search.student_requests(_requests)),
        ),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
        child: requests != null
            ? ListView.builder(
                itemCount: requests.docs.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(requests.docs[i].data()['title']),
                    subtitle: Text(requests.docs[i].data()['desc']),
                  );
                },
              )
            : Center(child: Text('Error')),
      ),
    );

    final pageBody = SingleChildScrollView(
      child: Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              requestListWidget,
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: appBar,
        body: pageBody,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(NewRequest.routeName)
                  .then((status) {
                if (status == true) {
                  requestReciept();
                }
              });
            },
            backgroundColor: Theme.of(context).primaryColor));
  }
}






// Search
class StudentRequests extends StatefulWidget {
  final List<Request> _requests;
  bool searchState;

  StudentRequests.list(this._requests) {
    this.searchState = false;
  }
  StudentRequests.search(this._requests) {
    this.searchState = true;
  }

  _StudentRequestsState createState() => _StudentRequestsState();
}

class _StudentRequestsState extends State<StudentRequests> {
  @override
  Widget build(BuildContext context) {
    String errorMessage;

    if (widget.searchState == true) {
      errorMessage = "No results.";
    } else {
      errorMessage =
          "You do not have any requests. Tap the \'+\' button to create one.";
    }

    return widget._requests.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: Center(
                      child: Text(
                        "Placeholder",
                        // errorMessage,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => RequestCard(widget._requests[index]),
            itemCount: widget._requests.length,
          );
  }
}
