import 'package:flutter/material.dart';

import '../../models/request.dart';

// Request functions
import '../../widgets/student/my_requests.dart';
import '../../widgets/student/request_functions.dart';

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
  
  void _startNewRequest(BuildContext ctx) {

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
  }

  void _startRequestFunction(BuildContext ctx, Request request, int index, bool edit) {
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

  void _requestFunction(String title, String desc, DateTime chosenDate, int index, bool isNewRequest) {
    final updateRequest =
        Request(DateTime.now().toString(), title, desc, DateTime.now());
    if (isNewRequest==false) {
      setState(() {
        _studentRequests[index] = updateRequest;
      });
    }
    else {
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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewRequest(context),
        ),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.9,
      child: MyRequests(_studentRequests, _deleteRequest, _startRequestFunction),
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
