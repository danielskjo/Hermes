import 'package:flutter/material.dart';

import '../../models/request.dart';

// Request functions
import '../../widgets/student/student_request_constructor.dart';
import '../../widgets/student/student_request_functions.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/search.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<Request> _studentRequests = [
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

  void _startRequestFunction(
      BuildContext ctx, Request request, int index, bool edit) {
    showBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: RequestFunction.edit(_requestFunction, request, index),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _requestFunction(String title, String desc, DateTime chosenDate,
      int index, bool isNewRequest) {
    final updateRequest =
        Request(DateTime.now().toString(), title, desc, DateTime.now());
    if (isNewRequest == false) {
      setState(() {
        _studentRequests[index] = updateRequest;
      });
    } else {
      setState(() {
        _studentRequests.add(updateRequest);
      });
    }
  }

  void _deleteRequest(String id) {
    setState(() {
      _studentRequests.removeWhere((request) {
        return request.id == id;
      });
    });
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
              delegate: Search.student_requests(
                  _startRequestFunction, _deleteRequest, _studentRequests)),
        ),
        IconButton(
            // Create new request
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestFunction()));
            }),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          1,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
          child: MyRequests(
              _studentRequests, _deleteRequest, _startRequestFunction, false)),
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
