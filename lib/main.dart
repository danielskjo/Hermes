import 'package:flutter/material.dart';

// Models
import './models/request.dart';

// Routes
import './routes/student/student_tabs.dart';
import './routes/student/student_home.dart';
import './routes/student/student_chats.dart';
import './routes/student/student_profile.dart';

// Widgets
import './widgets/student/new_request.dart';
import './widgets/student/my_requests.dart';

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
      initialRoute: '/',
      routes: {
        '/': (ctx) => StudentTabs(),
        StudentChats.routeName: (ctx) => StudentChats(),
        StudentProfile.routeName: (ctx) => StudentProfile(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => StudentHome());
      },
    );
  }
}