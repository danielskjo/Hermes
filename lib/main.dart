// Flutter Packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Firebase Auth
import './services/auth.dart';

// Models
import './models/my_user.dart';

// Onboarding Screens
import './screens/onboarding/login.dart';
import './screens/onboarding/register.dart';
import './screens/onboarding/donor_register.dart';
import './screens/onboarding/student_register.dart';

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
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
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
          StudentRegister.routeName: (ctx) => StudentRegister(),
          DonorTabs.routeName: (ctx) => DonorTabs(),
          DonorRegister.routeName: (ctx) => DonorRegister(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (ctx) => Login());
        },
      ),
    );
  }
}

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