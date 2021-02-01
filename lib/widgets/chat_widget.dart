import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/chat.dart';

class ChatWidget extends StatefulWidget {
  final List<Chat> messages;
  final Function deleteConversation;
  final bool searchState;

  ChatWidget(this.messages, this.deleteConversation, this.searchState);

  ChatWidgetState createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> {

  String errorMessage;

  void _deleteValidation(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => showAlertDialog(context, id),
    );
  }

  void initState() {
    if (widget.searchState == true) {
      errorMessage = "No results.";
    }
    else {
      errorMessage = "You do not have any messages yet. Tap the \'+\' button to create a new message!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.messages.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                        // style: Theme.of(context).textTheme.title,
                      ),
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
                                    (widget.messages[index].sender.length > 20)
                                        ? '${widget.messages[index].sender.substring(0, 17)}...'
                                        : '${widget.messages[index].sender}',
                                    // style: Theme.of(context).textTheme.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '${DateFormat.yMMMd().format(widget.messages[index].date)}',
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  height: 25,
                                  width: 25,
                                  child: Center(child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15)),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 5),
                              child: Text(
                                  (widget.messages[index].message.length > 80)
                                      ? '${widget.messages[index].message.substring(0, 80)}...'
                                      : '${widget.messages[index].message}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.black45)),
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
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => _deleteValidation(widget.messages[index].id),
                  )
                ],
              );
            },
            itemCount: widget.messages.length,
          );
  }

  Widget showAlertDialog(BuildContext context, String id) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed: () {
        widget.deleteConversation(id);
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you would like to delete your message?"),
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