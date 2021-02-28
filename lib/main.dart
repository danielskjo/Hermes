// Flutter Packages
import 'dart:io';

import 'package:csulb_dsc_2021/screens/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };

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
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (ctx, ss) {
                if (ss.hasData && ss.data != null) {
                  final userDoc = ss.data;
                  final user = userDoc.data();
                  if (user['role'] == 'student') {
                    return StudentTabs();
                  } else if (user['role'] == 'donor') {
                    return DonorTabs();
                  } else {
                    return Loading();
                  }
                }
                return Wrapper();
              },
            );
          }
          return Login();
        });
  }
}
