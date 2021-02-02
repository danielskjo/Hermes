import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;

  ChatCard(this.chat);

  @override
  Widget build(BuildContext context) {
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
                        (chat.sender.length > 20)
                            ? '${chat.sender.substring(0, 17)}...'
                            : '${chat.sender}',
                        // style: Theme.of(context).textTheme.sender,
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
                            '${DateFormat.yMMMd().format(chat.date)}',
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
                      (chat.message.length > 80)
                          ? '${chat.message.substring(0, 80)}...'
                          : '${chat.message}',
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
    );
  }
}
