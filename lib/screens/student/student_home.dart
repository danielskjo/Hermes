import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

// Screens
import './new_request.dart';
import './student_request_tile.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';
import '../../widgets/search_bar.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String uid;

  Stream requests;

  bool isSearching = false;
  TextEditingController searchField = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserID();
    fetchUsersRequests(uid);
  }

  fetchUserID() {
    uid = FirebaseAuth.instance.currentUser.uid;
  }

  fetchUsersRequests(String uid) async {
    await DatabaseService().getUsersRequestsData(uid).then((results) {
      setState(() {
        requests = results;
      });
    });
  }

  void createdReceipt() {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Request successfully created'),
        duration: Duration(
          seconds: 2,
        ),
        action: SnackBarAction(
          label: 'View request',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Requests',
      ),
    );

    Widget requestList = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top),
        padding: const EdgeInsets.only(bottom: 50),
        child: StreamBuilder(
          stream: requests,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot request = snapshot.data.docs[index];
                  return StudentRequestTile(context, request);
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else {
              return Container(
                child: Text('No existing requests'),
              );
            }
          },
        ));

    final pageBody = SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SearchBar(isSearching, searchField),
              requestList,
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(NewRequest.routeName).then((status) {
            fetchUsersRequests(uid);
            if (status == true) {
              createdReceipt();
            }
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
