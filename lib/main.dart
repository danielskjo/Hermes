import 'package:flutter/material.dart';

// Login
import './screens/onboarding/loading.dart';
import './screens/onboarding/login.dart';
import './screens/onboarding/register.dart';
// Models

// Routes
import './screens/student/student_tabs.dart';
import './screens/student/student_home.dart';
import './screens/student/student_chats.dart';
import './screens/student/student_profile.dart';

import './screens/donor/donor_tabs.dart';
import './screens/donor/donor_home.dart';
import './screens/donor/donor_chats.dart';
import './screens/donor/donor_profile.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Loading.routeName,
      routes: {
        Loading.routeName: (ctx) => Loading(),
        Login.routeName: (ctx) => Login(),
        Register.routeName: (ctx) => Register(),
        StudentTabs.routeName: (ctx) => StudentTabs(),
        StudentHome.routeName: (ctx) => StudentHome(),
        StudentChats.routeName: (ctx) => StudentChats(),
        StudentProfile.routeName: (ctx) => StudentProfile(),
        DonorTabs.routeName: (ctx) => DonorTabs(),
        DonorHome.routeName: (ctx) => DonorHome(),
        DonorChats.routeName: (ctx) => DonorChats(),
        DonorProfile.routeName: (ctx) => DonorProfile(),

      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => StudentHome());
      },
    );
  }
}
