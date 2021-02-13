import 'package:csulb_dsc_2021/screens/donor/request_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

// Models
import '../../models/request.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/search.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
// Need to delete after fixing the search
  final List<Request> _requests = [];

  QuerySnapshot requests;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  fetchRequests() {
    DatabaseService().getRequestsData().then((results) {
      setState(() {
        requests = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'Available Requests',
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          // Search icon
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context, delegate: Search.donor_requests(_requests)),
        ),
      ],
    );

    final requestList = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
        child: requests != null
            ? ListView.builder(
                itemCount: requests.docs.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
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
                        Navigator.of(context).pushNamed(
                          RequestDetails.routeName,
                          arguments: requests.docs[i].id,
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            height: 75,
                            width: 75,
                            child: Center(
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.blue,
                              ),
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
                                        (requests.docs[i]
                                                    .data()['title']
                                                    .length >
                                                15)
                                            ? '${requests.docs[i].data()['title']}...'
                                                    .substring(0, 15) +
                                                '...'
                                            : '${requests.docs[i].data()['title']}',
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
                                            '${DateFormat.yMMMd().format(requests.docs[i].data()['date'].toDate())}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey, size: 15)),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 5),
                                  child: Text(
                                    (requests.docs[i]
                                                .data()['username']
                                                .length >
                                            35)
                                        ? '${requests.docs[i].data()['username']}'
                                                .substring(0, 35) +
                                            '...'
                                        : '${requests.docs[i].data()['username']}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  padding: const EdgeInsets.only(
                                      bottom: 5, right: 5),
                                  child: Text(
                                      (requests.docs[i].data()['desc'].length >
                                              35)
                                          ? '${requests.docs[i].data()['desc'].substring(0, 35)}...'
                                          : '${requests.docs[i].data()['desc']}',
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
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );

    final pageBody = SingleChildScrollView(
      child: Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              requestList,
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class DonorRequests extends StatefulWidget {
  final List<Request> _requests;
  bool searchState;

  DonorRequests.list(this._requests) {
    this.searchState = false;
  }
  DonorRequests.search(this._requests) {
    this.searchState = true;
  }

  _DonorRequestsState createState() => _DonorRequestsState();
}

class _DonorRequestsState extends State<DonorRequests> {
  @override
  Widget build(BuildContext context) {
    String errorMessage;

    if (widget.searchState == true) {
      errorMessage = "No results.";
    } else {
      errorMessage = "You have no available requests.";
    }

    return widget._requests.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
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
            // itemBuilder: (ctx, index) {return RequestCard(widget._requests[index]);},
            itemCount: widget._requests.length,
          );
  }
}
