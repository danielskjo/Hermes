import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  static const routeName = '/student-profile';

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
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
