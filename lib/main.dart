import 'package:flutter/material.dart';

// Login
import './login/loading.dart';
import './login/login.dart';

// Models

// Routes
import './routes/student/student_tabs.dart';
import './routes/student/student_home.dart';
import './routes/student/student_chats.dart';
import './routes/student/student_profile.dart';

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
        StudentTabs.routeName: (ctx) => StudentTabs(),
        StudentHome.routeName: (ctx) => StudentHome(),
        StudentChats.routeName: (ctx) => StudentChats(),
        StudentProfile.routeName: (ctx) => StudentProfile(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => StudentHome());
      },
    );
  }
}
