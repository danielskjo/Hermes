import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csulb_dsc_2021/screens/chat/search_results.dart';
import 'package:flutter/material.dart';


class SearchUsers extends SearchDelegate {

  final searchFieldLabel = 'Search username ...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChatSearchResults(queryResults:query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    QuerySnapshot querySnapshot;
    // TODO: implement buildSuggestions
    return Text('testing');
  }

}