// Flutter Packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

// Firebase Auth
import './services/auth.dart';

// Onboarding Screens
import './screens/onboarding/login.dart';
import './screens/onboarding/register.dart';

// Student Screens
import './screens/student/student_tabs.dart';

// Donor Screens
import './screens/donor/donor_tabs.dart';

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
      home: Wrapper(),
      routes: {
        Login.routeName: (ctx) => Login(),
        Register.routeName: (ctx) => Register(),
        StudentTabs.routeName: (ctx) => StudentTabs(),
        DonorTabs.routeName: (ctx) => DonorTabs(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => Login());
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StudentTabs();
            
          }
          return Login();
        });
  }
}
