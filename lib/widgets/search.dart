import 'package:flutter/material.dart';
import '../screens/student/student_home.dart';

// Models
import '../models/request.dart';
import '../models/chat.dart';

// Widgets
import 'donor/donor_request_constructor.dart';
import 'chat_constructor.dart';

class Search extends SearchDelegate {

  final List list;
  int searchType;

  Search.student_requests(this.list) {this.searchType = 1;}
  Search.donor_requests(this.list,) {this.searchType = 2;}
  Search.chats(this.list) {this.searchType = 3;}

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

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    switch (searchType) {
      case 1: 
        List<Request> suggestionList = [];
        suggestionList.addAll(list.where(
          (element) => element.contains(query),
        ));
        return StudentRequests.search(suggestionList); 
      case 2:
        List<Request> suggestionList = [];
        suggestionList.addAll(list.where(
          (element) => element.contains(query),
        ));
        return DonorRequests.search(suggestionList); 
      case 3: 
        List<Chat> suggestionList = [];
        suggestionList.addAll(list.where(
          (element) => element.contains(query),
        ));
        return ChatWidget.search(suggestionList); 
      default:
        return null;
    }
  }
}