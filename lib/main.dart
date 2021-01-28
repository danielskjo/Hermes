import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/authenticate/wrapper.dart';

// Login
import './screens/onboarding/login.dart';
import './screens/onboarding/register.dart';
import './screens/onboarding/donor_register.dart';
import './screens/onboarding/student_register.dart';

// Models

// Routes
import './screens/onboarding/loading.dart';

import './screens/student/student_tabs.dart';
import './screens/student/student_home.dart';
import './screens/student/student_chats.dart';
import './screens/student/student_profile.dart';

import './screens/donor/donor_tabs.dart';
import './screens/donor/donor_home.dart';
import './screens/donor/donor_chats.dart';
import './screens/donor/donor_profile.dart';
void main() async { 
     WidgetsFlutterBinding.ensureInitialized(); 
     await Firebase.initializeApp(); 
     runApp(MyApp()); 
}

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
      home: Loading(),
      // Wrapper()
      routes: {
        Loading.routeName: (ctx) => Loading(),
        Login.routeName: (ctx) => Login(),
        Register.routeName: (ctx) => Register(),
        StudentTabs.routeName: (ctx) => StudentTabs(),
        StudentHome.routeName: (ctx) => StudentHome(),
        StudentChats.routeName: (ctx) => StudentChats(),
        StudentProfile.routeName: (ctx) => StudentProfile(),
        StudentRegister.routeName: (ctx) => StudentRegister(),
        DonorTabs.routeName: (ctx) => DonorTabs(),
        DonorHome.routeName: (ctx) => DonorHome(),
        DonorChats.routeName: (ctx) => DonorChats(),
        DonorProfile.routeName: (ctx) => DonorProfile(),
        DonorRegister.routeName: (ctx) => DonorRegister(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => StudentHome());
      },
    );
  }
}
