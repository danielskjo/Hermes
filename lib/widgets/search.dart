import 'package:flutter/material.dart';

// Models
import '../models/request.dart';
import '../models/chat.dart';

// Widgets
import 'student/student_request_constructor.dart';
import 'donor/donor_request_constructor.dart';
import 'chat_constructor.dart';

class Search extends SearchDelegate {

  // Student requests search specific values

  Function _startRequestFunction;
  Function _delete;

  // Donor requests search specific values
  
  Function _acceptRequest;
  Function _denyRequest;

  final List list;
  int searchType;

  Search.student_requests(this._startRequestFunction, this._delete, this.list) {this.searchType = 1;}
  Search.donor_requests(this.list, this._acceptRequest, this._denyRequest) {this.searchType = 2;}
  Search.chats(this._delete, this.list) {this.searchType = 3;}

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
        List<Request> suggestionList = [];
        suggestionList.addAll(list.where(
          (element) => element.contains(query),
        ));
        return AvailableRequests(suggestionList, _acceptRequest, _denyRequest, true); 
      case 3: 
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
