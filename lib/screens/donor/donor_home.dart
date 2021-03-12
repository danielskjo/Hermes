import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

import './request_details.dart';

// Widgets
import '../../widgets/graphics.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  Stream requests;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  fetchRequests() async {
    await DatabaseService().getRequestsData().then((results) {
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
    );

    Widget requestList = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top),
      padding: const EdgeInsets.only(bottom: 50),
      child: StreamBuilder(
        stream: requests,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot request = snapshot.data.docs[index];
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
                        arguments: request.id,
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        request['imageUrl'] != null
                            ? Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                height: 75,
                                width: 75,
                                child: Center(
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(request['imageUrl']),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                height: 75,
                                width: 75,
                                child: Center(
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/img/default.jpg'),
                                      ),
                                    ),
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
                                      (request['title'].length > 15)
                                          ? '${request['title']}...'
                                                  .substring(0, 15) +
                                              '...'
                                          : '${request['title']}',
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
                                          '${DateFormat.yMMMd().format(request['date'].toDate())}',
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
                                  (request['username'].length > 35)
                                      ? '${request['username']}'
                                              .substring(0, 35) +
                                          '...'
                                      : '${request['username']}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ),
                              Container(
                                height: 30,
                                padding:
                                    const EdgeInsets.only(bottom: 5, right: 5),
                                child: Text(
                                    (request['desc'].length > 35)
                                        ? '${request['desc'].substring(0, 35)}...'
                                        : '${request['desc']}',
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
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: Text('No existing messages'),
            );
          }
        },
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
