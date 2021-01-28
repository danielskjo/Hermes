import 'package:flutter/material.dart';

import './login.dart';
import '../authenticate/wrapper.dart';

// Widgets
import '../../widgets/graphics.dart';

class Loading extends StatefulWidget {
  static const routeName = '/loading';

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Logo(150),
          ProjectTitle(),
          Spacer(flex: 1),
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
          Spacer(),
          ElevatedButton(
            child: Text("To login screen"),
            onPressed: () {
              Navigator.of(context).pushNamed(Login.routeName);
            },
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}