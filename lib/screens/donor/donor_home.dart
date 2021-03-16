import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './donor_request_tile.dart';

import '../../services/database.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';
import '../../widgets/search_bar.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  Stream requests;
  Stream searchResults;

  bool isSearching = false;
  TextEditingController searchField = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  fetchRequests() async {
    await DatabaseService().getRequestsData().then((results) {
      setState(() {
        requests = results;
      });
    });
  }

  onSearchButtonClicked() async {
    await DatabaseService().getRequestsByTitle(searchField.text).then((value) {
      searchResults = value;
      setState(() {
        isSearching = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'Available Requests',
      ),
    );

    Widget searchBar = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          /// Only display arrow back icon when user is searching
          isSearching
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = false;
                      searchField.text = "";
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
                      controller: searchField,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search by title',
                      ),
                    ),
                  ),

                  /// Gesture Detection logic when search icon is tapped
                  IconButton(
                    onPressed: () async {
                      if (searchField.text.isNotEmpty) {
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
                return DonorRequestTile(request);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return Container(
              child: Text('No existing messages'),
            );
          }
        },
      ),
    );

    Widget searchList = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
      padding: const EdgeInsets.only(bottom: 50),
      child: StreamBuilder(
        stream: searchResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot request = snapshot.data.docs[index];
                return DonorRequestTile(request);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return Container(
              child: Text('No messages found'),
            );
          }
        },
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
              isSearching ? searchList : requestList,
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
