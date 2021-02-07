import 'package:flutter/material.dart';

// Models
import '../../models/request.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/donor/donor_request_constructor.dart';
import '../../widgets/search.dart';

class DonorHome extends StatefulWidget {
  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {

  final List<Request> _studentRequests = [
    Request(DateTime.now().toString(), 'Bread',
        'I want to make some lunch with this bread.', DateTime.now()),
    Request(DateTime.now().toString(), 'Textbook',
        'In need of this book for class.', DateTime.now()),
  ];

  void _acceptRequest(String id) {
    setState(() {
      _studentRequests.removeWhere((request) {
        return request.id == id;
      });
    });
  }

  void _denyRequest(String id) {
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
        'Available Requests',
      ),
      actions: <Widget>[
        IconButton( // Search icon
          icon: Icon(Icons.search),
          onPressed: () => showSearch(context: context, delegate: Search.donor_requests(_studentRequests, _acceptRequest, _denyRequest)),
        ),
      ],
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.9,
      child: AvailableRequests(_studentRequests, _acceptRequest, _denyRequest, true),
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
