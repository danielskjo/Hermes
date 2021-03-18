// Flutter Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Screens
import './conversation_tile.dart';
import './search_results_tile.dart';

// Services
import '../../services/database.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';

class ChatHome extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
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

  @override
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
          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Snapshot Error receiving searched users from chat view'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length == 0) {
              return Expanded(child: Center(child: Text("No user found")));
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot documentSnapshot =
                    snapshot.data.docs[index];
                return SearchResultsTile(
                  userName: documentSnapshot['username'],
                  userEmail: documentSnapshot['email'],
                );
              },
            );
          } else {
            return Text('');
          }
        });
  }

  Widget existingConversationsList() {
    return StreamBuilder(
        stream: existingConversations,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Snapshot Error receiving existing conversations from chat view'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Expanded(
              child: Center(
                child: Loading(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length == 0) {
              return Expanded(
                child: Center(
                  child: Text("You do not have any existing conversations"),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot documentSnapshot =
                    snapshot.data.docs[index];
                return ConversationTile(documentSnapshot: documentSnapshot);
              },
            );
          } else {
            return Text('');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      elevation: 0.0,
      title: Text('My Messages'),
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
                      isSearching = false;
                      searchUserName.text = "";
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
    );

    final conversationsList =
        isSearching ? searchedUsersList() : existingConversationsList();

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
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              searchBar,
              conversationsList,
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
