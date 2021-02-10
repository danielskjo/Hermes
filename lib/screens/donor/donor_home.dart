import 'package:flutter/material.dart';

// Models
import '../../models/request.dart';

// Cards
import '../../cards/request_card.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/search.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {

  final List<Request> _requests = [
    Request(DateTime.now().toString(), 'Bread',
        'I want to make some lunch with this bread.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
    Request(DateTime.now().toString(), 'BOTTOM', 'BOTTOM', DateTime.now()),
  ];

  // void _acceptRequest(String id) {
  //   setState(() {
  //     _requests.removeWhere((request) {
  //       return request.id == id;
  //     });
  //   });
  // }

  // void _denyRequest(String id) {
  //   setState(() {
  //     _requests.removeWhere((request) {
  //       return request.id == id;
  //     });
  //   });
  // }

  @override
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
              context: context,
              delegate: Search.donor_requests(_requests)),
        ),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
          child: DonorRequests.list(_requests),
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
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              requestListWidget,
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

  DonorRequests.list(this._requests) {this.searchState = false;}
  DonorRequests.search(this._requests) {this.searchState = true;}

  _DonorRequestsState createState() => _DonorRequestsState();

}

class _DonorRequestsState extends State<DonorRequests> {

  @override
  Widget build(BuildContext context) {

    String errorMessage;

    if (widget.searchState == true) {
      errorMessage = "No results.";
    }
    else {
      errorMessage = "You have no available requests.";
    }

    return widget._requests.isEmpty
      ? LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
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
          itemBuilder: (ctx, index) {return RequestCard(widget._requests[index]);},
          itemCount: widget._requests.length,
      );
  }
}
