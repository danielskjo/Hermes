import 'package:csulb_dsc_2021/screens/donor/donor_tabs.dart';
import 'package:csulb_dsc_2021/screens/student/student_tabs.dart';
import 'package:csulb_dsc_2021/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

class OnBoarding extends StatefulWidget {
  static const routeName = '/onboarding';
  String userRole = '';

  OnBoarding({this.userRole});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String uid;

  void initState() {
    super.initState();
    fetchUserID();
  }

  fetchUserID() {
    uid = FirebaseAuth.instance.currentUser.uid;
  }
  final pageList = [
    PageModel(
      color: Color(0xFF01579B),
      heroImagePath: 'assets/img/target.png',
      title: Text(
        "Welcome to Hermes!",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Text(""),
      iconImagePath: '',
    ),
    PageModel(
      color: Color(0xFF0277BD),
      heroImagePath: 'assets/img/goal.png',
      title: Text(
        "Purpose",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Text(
        "This app is designed to help donors distribute resources for students in need.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      iconImagePath: '',
    ),
    PageModel(
      color: Color(0xFF0288D1),
      heroImagePath: 'assets/img/heart.png',
      title: Text(
        "Give and Take",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Text(
        "Students can create requests to their donors and receive their needs!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      iconImagePath: '',
    ),
    PageModel(
      color: Color(0xFF039BE5),
      heroImagePath: 'assets/img/chat.png',
      title: Text(
        "Chat",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      body: Text(
        "Students can chat with their donors about their needs.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      iconImagePath: '',
    ),
  ];

  NavigateToTabs() async {
    /// update onbaording status of current user
    await DatabaseService().updateOnboardingStatus(uid)
        .then((value) {
          if(widget.userRole == 'student') {
            return StudentTabs();
          } else {
            return DonorTabs();
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        onDoneButtonPressed: () =>
            NavigateToTabs(),
            // Navigator.of(context).pushNamed(StudentTabs.routeName),
        onSkipButtonPressed: () =>
            NavigateToTabs(),
            // Navigator.of(context).pushNamed(StudentTabs.routeName),
        pageList: pageList,
      ),
    );
  }
}
