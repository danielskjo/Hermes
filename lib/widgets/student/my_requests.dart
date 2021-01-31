import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/request.dart';

class MyRequests extends StatelessWidget {
  final List<Request> requests;
  final Function deleteRequest;

  MyRequests(this.requests, this.deleteRequest);

  @override
  Widget build(BuildContext context) {
    return requests.isEmpty
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
                    (requests[index].title.length > 20)
                        ? '${requests[index].title.substring(0, 17)}...'
                        : '${requests[index].title}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    (requests[index].desc.length > 20)
                        ? '${requests[index].desc.substring(0, 25)}...\n${DateFormat.yMMMd().format(requests[index].date)}'
                        : '${requests[index].desc}\n${DateFormat.yMMMd().format(requests[index].date)}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // TODO
                    },
                  )
                ),
              );
            },
            itemCount: requests.length,
          );
  }
}
