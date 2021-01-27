import 'package:flutter/material.dart';

class DonorHome extends StatefulWidget {
  static const routeName = '/donor-home';

  @override
  _DonorHomeState createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
   @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
      title: Text(
        'All Requests',
      ),
    );

    final requestListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.9,
      child: null,
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
