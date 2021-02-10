import 'package:csulb_dsc_2021/screens/student/new_request.dart';
import 'package:csulb_dsc_2021/screens/student/edit_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../../models/request.dart';

// Cards
import '../../cards/request_card.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/search.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

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

  /*void _startNewRequest(BuildContext ctx) {
    Request tmp = new Request("", "", "", DateTime.now());


    showBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: RequestFunction.create(_requestFunction, tmp),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }*/

  // void _startRequestFunction(
  //     BuildContext ctx, Request request, int index, bool edit) {
  //   showBottomSheet(
  //     context: ctx,
  //     builder: (_) {
  //       return GestureDetector(
  //         onTap: () {},
  //         child: RequestFunction.edit(_requestFunction, request, index),
  //         behavior: HitTestBehavior.opaque,
  //       );
  //     },
  //   );
  // }

  // void _requestFunction(String title, String desc, DateTime chosenDate,
  //     int index, bool isNewRequest) {
  //   final updateRequest =
  //       Request(DateTime.now().toString(), title, desc, DateTime.now());
  //   if (isNewRequest == false) {
  //     setState(() {
  //       _requests[index] = updateRequest;
  //     });
  //   } else {
  //     setState(() {
  //       _requests.add(updateRequest);
  //     });
  //   }
  // }

  // void _deleteRequest(String id) {
  //   setState(() {
  //     _requests.removeWhere((request) {
  //       return request.id == id;
  //     });
  //   });
  // }

  void requestReciept() {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Container(
        // height: 20, 
        child: Row(
          children: <Widget>[
            Text("New request created. "), 
            Ink(
              child: InkWell(
                child: Text(
                  "View request",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
            )
          ]
        )
      ), duration: Duration(seconds: 2)
    ));
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Requests',
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          // Search icon
          icon: Icon(Icons.search),
          onPressed: () => showSearch(
              context: context,
              delegate: Search.student_requests(_requests)),
        ),
        // IconButton(
        //   // Create new request
        //   icon: Icon(Icons.add),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(NewRequest.routeName).then((status){
        //       if (status == true) {
        //         requestReciept();
        //       }
        //     }  );   
        //   }),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
          child: StudentRequests.list(_requests),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pushNamed(NewRequest.routeName).then((status){
            if (status == true) {
              requestReciept();
            }
          });   
        },
        backgroundColor: Theme.of(context).primaryColor
      )
    );
  }
}

class StudentRequests extends StatefulWidget {
  final List<Request> _requests;
  bool searchState;

  StudentRequests.list(this._requests) {this.searchState = false;}
  StudentRequests.search(this._requests) {this.searchState = true;}

  _StudentRequestsState createState() => _StudentRequestsState();
}

class _StudentRequestsState extends State<StudentRequests> {

  @override
  Widget build(BuildContext context) {

    String errorMessage;
    if (widget.searchState == true) {
      errorMessage = "No results.";
    }
    else {
      errorMessage = "You do not have any requests. Tap the \'+\' button to create one.";
    }

    return widget._requests.isEmpty
      ? LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Center(
                  child: Text(
                    "Placeholder",
                    // errorMessage,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
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
        itemBuilder: (ctx, index) => RequestCard(widget._requests[index]),
        itemCount: widget._requests.length,
      );
  }
}