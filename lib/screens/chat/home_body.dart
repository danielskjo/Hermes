import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/search_results_tile.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';
import 'package:csulb_dsc_2021/services/helper/helperFunctions.dart';
import 'package:flutter/material.dart';

/// The ChatHomeBody will encapsulate all widgets
/// for displaying previous messages and searching for users
/// for the current user to communicate with

class ChatHomeBody extends StatefulWidget {
  @override
  _ChatHomeBodyState createState() => _ChatHomeBodyState();
}

class _ChatHomeBodyState extends State<ChatHomeBody> {

  bool isSearching = false;
  TextEditingController searchUserName = TextEditingController();
  Stream usersFound, existingConversations;

  onSearchButtonClicked() async {
    usersFound = await DatabaseService().getUserByUsername(searchUserName.text);
    setState(() {
      isSearching = true;
    });
  }

  Widget searchedUsersList() {
    return StreamBuilder(
      stream: usersFound,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return SearchResultsTile(
                userName: documentSnapshot['username'],
                userEmail: documentSnapshot['email'],
              );
            },
          );
        } else if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
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
        return snapshot.hasData ?
          ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              print('last message: ' + documentSnapshot['lastMessage']);
              return Text('last message sent: ' + documentSnapshot['lastMessage']);
            },
          ) : Center(child: CircularProgressIndicator(),);
      }
    );
  }

  getExistingConversations() async {
    DatabaseService().getChatRooms()
      .then((value) {
       setState(() {
         existingConversations = value;
       });
    });
    // existingConversations = await DatabaseService().getChatRooms();
    // setState(() {});
  }

  void initState() {
    print('my username: ' + Constants.myUserName);
    getExistingConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      child: Column(
        children: [
          /// Search User Bar
          Row(
            children: [
              /// Only display arrow back icon when user is searching
              isSearching ? GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = false;
                    searchUserName.text = "";
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0,),
                  child: Icon(Icons.arrow_back),
                ),
              ) : Container(),
              /// Textfield for searching for a user
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16,),
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
                          if(searchUserName.text.isNotEmpty) {
                              onSearchButtonClicked();
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
          isSearching ? searchedUsersList() : existingConversationsList(),
        ],
      ),
    );
  }
}
