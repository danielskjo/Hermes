import 'package:flutter/material.dart';

class DonorProfile extends StatefulWidget {

  static const routeName = '/donor-profile';

  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
      title: Text(
        'My Profile',
      ),
    );

    final pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
    );
  }
}
