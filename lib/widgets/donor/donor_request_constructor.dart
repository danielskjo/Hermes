import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

// Models
import '../../models/request.dart';

// Widgets
import '../request_card.dart';

class AvailableRequests extends StatefulWidget {
  final List<Request> requests;
  final Function acceptRequest;
  final Function denyRequest;
  bool searchState;

  AvailableRequests(this.requests, this.acceptRequest, this.denyRequest, this.searchState);

  _AvailableRequestsState createState() => _AvailableRequestsState();

}

class _AvailableRequestsState extends State<AvailableRequests> {

  String errorMessage;

  @override
  void initState() {
    if (widget.searchState == true) {
      errorMessage = "No results.";
    }
    else {
      errorMessage = "You have no available requests.";
    }
  }

  void _acceptRequest(String id) {
    widget.acceptRequest(id);
  }

  void _denyRequest(String id) {
    widget.denyRequest(id);
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), duration: Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return widget.requests.isEmpty
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
            itemBuilder: (ctx, index) {
              return Slidable(
                key: Key(widget.requests[index].id),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: RequestCard(widget.requests[index]),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Accept',
                    color: Colors.green,
                    icon: Icons.check,
                    onTap: () {
                      _acceptRequest(widget.requests[index].id);
                      _showSnackBar(context, 'Request accepted');
                    }
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Dismiss',
                    color: Colors.red,
                    icon: Icons.close,
                    onTap: () {
                      _denyRequest(widget.requests[index].id);
                      _showSnackBar(context, 'Request dismissed');
                    }
                  )
                ],
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                  onDismissed: (actionType) {
                    _showSnackBar(
                      context,
                      actionType == SlideActionType.primary
                        ? 'Request accepted'
                        : 'Request dismissed'
                    );
                    setState(() {
                     actionType == SlideActionType.primary
                      ? _acceptRequest(widget.requests[index].id)
                      : _denyRequest(widget.requests[index].id);
                    });
                  }
                )
              );
            },
            itemCount: widget.requests.length,
          );
  }
}