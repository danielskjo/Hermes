import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

// Models
import '../../models/request.dart';

// Widgets
import '../../cards/request_card.dart';

class DonorRequests extends StatefulWidget {

  final List<Request> _requests;
  bool searchState;

  DonorRequests.list(this._requests) {this.searchState = false;}
  DonorRequests.search(this._requests) {this.searchState = true;}

  _DonorRequestsState createState() => _DonorRequestsState();

}

class _DonorRequestsState extends State<DonorRequests> {

  @override
  Widget build(BuildContext context) {

    String errorMessage;

    if (widget.searchState == true) {
      errorMessage = "No results.";
    }
    else {
      errorMessage = "You have no available requests.";
    }

    return widget._requests.isEmpty
      ? LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  // style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      )
      : ListView.builder(
          itemBuilder: (ctx, index) {return RequestCard(widget._requests[index]);},
          itemCount: widget._requests.length,
      );
  }
}