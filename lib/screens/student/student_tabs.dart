import 'package:flutter/material.dart';

import './student_home.dart';
import './student_chats.dart';
import './student_profile.dart';
import '../../widgets/profile.dart';

// Widgets
import '../../widgets/graphics.dart';

class StudentTabs extends StatefulWidget {
  static const routeName = '/student-tabs';

  @override
  _StudentTabsState createState() => _StudentTabsState();
}

class _StudentTabsState extends State<StudentTabs> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': StudentHome(),
        'title': 'Home',
      },
      {
        'page': StudentChats(),
        'title': 'Chats',
      },
      {
        'page': Profile(userType: "Student"),
        'title': 'Profile',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
