import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/conversation_screen.dart';
import 'package:csulb_dsc_2021/screens/chat/search_results_tile.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:flutter/material.dart';

import 'conversation_tile.dart';

/// The ChatHomeBody will encapsulate all widgets
/// for displaying previous messages and searching for users
/// for the current user to communicate with

class ChatHomeBody extends StatefulWidget {
  double appBarHeight;

  ChatHomeBody({this.appBarHeight});

  @override
  _ChatHomeBodyState createState() => _ChatHomeBodyState();
}

class _ChatHomeBodyState extends State<ChatHomeBody> {
  bool isSearching = false;
  TextEditingController searchUserName = TextEditingController();
  Stream usersFound, existingConversations;

  onSearchButtonClicked() async {
    await DatabaseService()
        .getUserByUsername(searchUserName.text)
        .then((value) {
          usersFound = value;
          setState(() {
            isSearching = true;
          });
    });
  }

  void initState() {
    super.initState();
    getExistingConversations();
  }

  getExistingConversations() async {
    await DatabaseService().getChatRooms().then((value) {
      setState(() {
        existingConversations = value;
      });
    });
  }

  Widget searchedUsersList() {
    return StreamBuilder(
      stream: usersFound,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return SearchResultsTile(
                userName: documentSnapshot['username'],
                userEmail: documentSnapshot['email'],
                index: index,
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          print('Error trying to display searched users in the chat home body');
          return Text('Search results could not be found');
        }
      },
    );
  }

  Widget existingConversationsList() {
    return StreamBuilder(
        stream: existingConversations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return ConversationTile(documentSnapshot: documentSnapshot);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: Text(''),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Container(
        height: (mediaQuery.size.height -
            widget.appBarHeight -
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
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Search User Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    /// Only display arrow back icon when user is searching
                    isSearching
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearching = false;
                                searchUserName.text = "";
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 12.0,
                                left: 4,
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
                                controller: searchUserName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search by username',
                                ),
                              ),
                            ),

                            /// Gesture Detection logic when search icon is tapped
                            IconButton(
                              onPressed: () async {
                                if (searchUserName.text.isNotEmpty) {
                                  await onSearchButtonClicked();
                                } else {
                                  /// TODO: Display snackbar notifying user to input text to search for a user
                                  print('Textfield is empty');
                                }
                              },
                              icon: Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isSearching ? searchedUsersList() : existingConversationsList(),
            ],
          ),
        ),
      ),
    );
  }
}
