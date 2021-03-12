import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

// Screens
import './new_request.dart';
import './edit_request.dart';

// Models
import '../../models/request.dart';

// Widgets
import '../../widgets/graphics.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  bool isSearching = false;

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

  void updatedReceipt() {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Request successfully updated'),
        duration: Duration(
          seconds: 2,
        ),
      ),
    );
  }

  void deletedReceipt() {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Request successfully deleted'),
        duration: Duration(
          seconds: 2,
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

    final searchBar = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          /// Only display arrow back icon when user is searching
          isSearching
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      // isSearching = false;
                      // searchUserName.text = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 12.0,
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                )
              : Container(),

          /// Textfield for searching for a user
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 16,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  /// Search by UserName textfield
                  Expanded(
                    child: TextField(
                      // controller: searchUserName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search by username',
                      ),
                    ),
                  ),

                  /// Gesture Detection logic when search icon is tapped
                  IconButton(
                    onPressed: () async {
                      // if (searchUserName.text.isNotEmpty) {
                      //   onSearchButtonClicked();
                      // } else {
                      //   /// TODO: Display snackbar notifying user to input text to search for a user
                      //   print('Textfield is empty');
                      // }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final requestList = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
        child: requests != null
            ? requests.docs.length != 0
                ? ListView.builder(
                    itemCount: requests.docs.length,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (context, i) {
                      return Ink(
                        padding: const EdgeInsets.only(),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(
                              EditRequest.routeName,
                              arguments: requests.docs[i].id,
                            )
                                .then((status) {
                              fetchUsersRequests(uid);

                              if (status == 'Updated') {
                                updatedReceipt();
                              } else if (status == 'Deleted') {
                                deletedReceipt();
                              }
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              requests.docs[i].data()['imageUrl'] != null
                                  ? Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      height: 75,
                                      width: 75,
                                      child: Center(
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(requests
                                                  .docs[i]
                                                  .data()['imageUrl']),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      height: 75,
                                      width: 75,
                                      child: Center(
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/img/default.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 25,
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            (requests.docs[i]
                                                        .data()['title']
                                                        .length >
                                                    15)
                                                ? '${requests.docs[i].data()['title']}...'
                                                        .substring(0, 15) +
                                                    '...'
                                                : '${requests.docs[i].data()['title']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                '${DateFormat.yMMMd().format(requests.docs[i].data()['date'].toDate())}',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          height: 25,
                                          width: 25,
                                          child: Center(
                                              child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                  size: 15)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 30,
                                      padding: const EdgeInsets.only(
                                          bottom: 5, right: 5),
                                      child: Text(
                                          (requests.docs[i]
                                                      .data()['desc']
                                                      .length >
                                                  35)
                                              ? '${requests.docs[i].data()['desc'].substring(0, 35)}...'
                                              : '${requests.docs[i].data()['desc']}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'You do not have any requests',
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );

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
              searchBar,
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

