import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/request.dart';

class MyRequests extends StatefulWidget {
  final List<Request> requests;
  final Function deleteRequest;
  final Function editRequest;

  MyRequests(this.requests, this.deleteRequest, this.editRequest);

  _MyRequestsState createState() => _MyRequestsState();
}
class _MyRequestsState extends State<MyRequests> {
  
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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                  ),
                  title: Text(
                    (widget.requests[index].title.length > 20)
                        ? '${widget.requests[index].title.substring(0, 17)}...'
                        : '${widget.requests[index].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    (widget.requests[index].desc.length > 20)
                        ? '${widget.requests[index].desc.substring(0, 25)}...\n${DateFormat.yMMMd().format(widget.requests[index].date)}'
                        : '${widget.requests[index].desc}\n${DateFormat.yMMMd().format(widget.requests[index].date)}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      widget.editRequest(context, widget.requests[index], index);
                    },
                  )
                ),
              );
            },
            itemCount: widget.requests.length,
          );
  }
}
