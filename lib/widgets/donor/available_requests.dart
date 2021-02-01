import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

// Models
import "../../models/request.dart";

class AvailableRequests extends StatefulWidget {
  final List<Request> requests;
  final Function acceptRequest;
  final Function denyRequest;

  AvailableRequests(this.requests, this.acceptRequest, this.denyRequest);

  _AvailableRequestsState createState() => _AvailableRequestsState();

}

class _AvailableRequestsState extends State<AvailableRequests> {

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
                  Text(
                    'There are no available requests',
                    style: Theme.of(context).textTheme.title,
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
                child: BuildCard(ctx, index),
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

  Widget BuildCard(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.only(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1, 
            color: Colors.grey[300],
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 75,
            width: 75,
            child: Center(
              child: Icon(Icons.person, size: 40),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 25,
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        (widget.requests[index].title.length > 20)
                          ? '${widget.requests[index].title.substring(0, 17)}...'
                          : '${widget.requests[index].title}',
                        // style: Theme.of(context).textTheme.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerRight,
                      child: Column(
                        children:  <Widget>[
                          Text(
                            '${DateFormat.yMMMd().format(widget.requests[index].date)}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                  child: Text(
                  (widget.requests[index].desc.length > 80)
                    ? '${widget.requests[index].desc.substring(0, 80)}...'
                    : '${widget.requests[index].desc}',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black45)
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
          )
        ],
      ),
    );
  }
}