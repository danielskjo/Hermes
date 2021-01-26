import 'package:flutter/material.dart';

import '../student/student_tabs.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(StudentTabs.routeName);
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
