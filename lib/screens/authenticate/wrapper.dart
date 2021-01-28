import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_user.dart';
import '../student/student_tabs.dart';
import './authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StudentTabs();
    }
  }
}
