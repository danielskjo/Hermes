import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './donor_request_tile.dart';

import '../../services/database.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';
import '../../widgets/search_bar.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  Stream requests;

  bool isSearching = false;
  TextEditingController searchField = TextEditingController();

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
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
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
                return DonorRequestTile(request);
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
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
              SearchBar(isSearching, searchField),
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
