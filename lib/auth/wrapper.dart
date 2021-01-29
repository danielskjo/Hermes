import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/onboarding/login.dart';
import '../models/my_user.dart';
import '../screens/student/student_tabs.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    if (user == null) {
      return Login();
    } else {
      return StudentTabs();
    }
  }
}
