import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/request.dart';

class MyRequests extends StatefulWidget {
  final List<Request> requests;
  final Function deleteRequest;
  final Function editRequest;

  MyRequests(this.requests, this.deleteRequest, this.editRequest);

  _MyRequestsState createState() => _MyRequestsState();
}
class _MyRequestsState extends State<MyRequests> {

  void _deleteValidation(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => showAlertDialog(context, id),
    );
  }
  @override
  Widget build(BuildContext context) {
    return widget.requests.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'You do not have any requests yet. Click the add button to create a new request!',
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
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
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
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.grey,
                    icon: Icons.edit,
                    onTap: () => widget.editRequest(context, widget.requests[index], index, true),
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => _deleteValidation(widget.requests[index].id),
                  )
                ],
              );
            },
            itemCount: widget.requests.length,
          );
  }

  Widget showAlertDialog(BuildContext context, String id) {

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () => Navigator.of(context).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed:  () {
        widget.deleteRequest(id);
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you would like to delete your request?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    return alert;
  }
}

// return Container(
//                 padding: const EdgeInsets.only(bottom: 15),
                // decoration: BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(
                //       width: 1, 
                //       color: Colors.grey[400],
                //     ),
                //   ),
                // ),
//                 margin: EdgeInsets.symmetric(
//                   vertical: 7,
//                   horizontal: 5,
//                 ),
                // child: ListTile(
                //   leading: Icon(
                //     Icons.person,
                //   ),
                //   title: Text(
                //     (widget.requests[index].title.length > 20)
                //         ? '${widget.requests[index].title.substring(0, 17)}...'
                //         : '${widget.requests[index].title}',
                //     style: Theme.of(context).textTheme.title,
                //   ),
                //   subtitle: Text(
                //     (widget.requests[index].desc.length > 20)
                //         ? '${widget.requests[index].desc.substring(0, 25)}...\n${DateFormat.yMMMd().format(widget.requests[index].date)}'
                //         : '${widget.requests[index].desc}\n${DateFormat.yMMMd().format(widget.requests[index].date)}',
                //   ),
                //   trailing: IconButton(
                //     icon: Icon(Icons.edit),
                //     onPressed: () {
                //       widget.editRequest(context, widget.requests[index], index, true);
                //     },
//                   )
//                 ),
//               );