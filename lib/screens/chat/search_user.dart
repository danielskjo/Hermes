import 'package:csulb_dsc_2021/screens/chat/search_results.dart';
import 'package:csulb_dsc_2021/screens/chat/search_suggestions.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:flutter/material.dart';


class SearchUsers extends SearchDelegate {

  final searchFieldLabel = 'Search username ...';
  DatabaseService databaseService = new DatabaseService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        /// resets the query
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
      /// returns to the chat room screen
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    /// TODO: Display CircularProgressionIndicator before result is found
    return ChatSearchResult(queryResults: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /// TODO: Implement build suggestions
    return Text('No suggestions');
  }

}