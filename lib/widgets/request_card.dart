import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/request.dart';

class RequestCard extends StatelessWidget {
  final Request request;

  RequestCard(this.request);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.only(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[300],
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          // Route to view full request
        },
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
                          (request.title.length > 20)
                              ? '${request.title.substring(0, 17)}...'
                              : '${request.title}',
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
                              '${DateFormat.yMMMd().format(request.date)}',
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
                        (request.desc.length > 80)
                            ? '${request.desc.substring(0, 80)}...'
                            : '${request.desc}',
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
    );
  }
}
