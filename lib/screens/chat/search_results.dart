import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/search_tile.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/widgets/graphics.dart';
import 'package:flutter/material.dart';
 

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseService databaseService = new DatabaseService();
  TextEditingController _usernameController = new TextEditingController();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseService
        .getUserByUsername(_usernameController.text)
        .then((result) {
          setState(() {
            searchSnapshot = result;
          });
    });
  }
  Widget SearchList() {
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SearchTile(
          userName: searchSnapshot.docs[index].get('username'),
          userEmail: searchSnapshot.docs[index].get('email'),
        );
      }
    ) : Container();

  }

  @override
  void initState() {
    initiateSearch();
  }

  void _handleSubmission(String text) {
    print('user text: ' + text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, title: Text('My Messages')),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        // onSubmitted: showSe,
                        controller: _usernameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search username...",
                        ),
                      ),
                  ),
                  // IconButton(
                  //     icon: Icon(Icons.search),
                  //     onPressed: () {
                  //       initiateSearch();
                  //     },
                  // ),
                ],
              ),
            ),
            SearchList(),
          ],
        ),
      ),
    );
  }
}



