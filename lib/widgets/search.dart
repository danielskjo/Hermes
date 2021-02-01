import 'package:flutter/material.dart';

// Models
import '../models/request.dart';
import '../models/chat.dart';

// Widgets
import './student/my_requests.dart';
import './chat_widget.dart';

class Search extends SearchDelegate {

  // Student requests search specific values

  Function _startRequestFunction;
  Function _delete;
  
  final List list;
  int searchType;

  Search.student_requests(this._startRequestFunction, this._delete, this.list) {this.searchType = 1;}
  Search.chats(this._delete, this.list) {this.searchType = 2;}

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
        return MyRequests(suggestionList, _delete, _startRequestFunction, true); 
      case 2: 
        List<Chat> suggestionList = [];
        suggestionList.addAll(list.where(
          (element) => element.contains(query),
        ));
        return ChatWidget(suggestionList, _delete, true); 
      default:
        return null;
    }
  }
}
