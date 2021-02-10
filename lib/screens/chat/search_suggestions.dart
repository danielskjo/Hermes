import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/search_tile.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:flutter/material.dart';


class ChatSearchSuggestions extends StatefulWidget {

  String queryResults;
  ChatSearchSuggestions({this.queryResults});

  @override
  _ChatSearchSuggestionsState createState() => _ChatSearchSuggestionsState();
}

class _ChatSearchSuggestionsState extends State<ChatSearchSuggestions> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot searchSnapshot;

  initiateSearch() {
    print('printing query from chat search suggestions: ' + widget.queryResults);
    databaseService
        .getUserByUsername(widget.queryResults)
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
    ) : Container(child: Text('No results'),);

  }

  @override
  // ignore: must_call_super
  void initState() {
    initiateSearch();
  }

  @override
  Widget build(BuildContext context) {
    return SearchList();
  }
}


