import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Models
import '../../models/chat.dart';

// Widgets
import 'chat_card.dart';

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
    final mediaQuery = MediaQuery.of(context);
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
                child: ChatCard(widget.messages[index]),
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
            padding: EdgeInsets.only(bottom: mediaQuery.size.height * 0.25)
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
    return alert;
  }
}