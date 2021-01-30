import 'package:flutter/material.dart';

import '../../models/request.dart';

import '../../widgets/student/new_request.dart';
import '../../widgets/student/my_requests.dart';

// Widgets
import '../../widgets/graphics.dart';

class StudentHome extends StatefulWidget {
  static const routeName = '/student-home';

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<Request> _studentRequests = [
    Request(DateTime.now().toString(), 'Bread',
        'I want to make some lunch with this bread.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
  ];

  void _addNewRequest(String title, String desc, DateTime chosenDate) {
    final newRequest =
        Request(DateTime.now().toString(), title, desc, DateTime.now());

    setState(() {
      _studentRequests.add(newRequest);
    });
  }

  void _startAddNewRequest(BuildContext ctx) {
    showBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewRequest(_addNewRequest),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewRequest(context),
        ),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.9,
      child: MyRequests(_studentRequests, _deleteRequest),
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          requestListWidget,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
    );
  }
}
