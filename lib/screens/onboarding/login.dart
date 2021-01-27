import 'package:flutter/material.dart';

import '../authenticate/auth.dart';

import '../student/student_tabs.dart';
import '../donor/donor_tabs.dart';
import '../onboarding/register.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  List<String> occupation = ["Student", "Donor"];
  String selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Icon(
                    Icons.headset_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "User",
                  hintText: "User",
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Password",
                ),
              ),
            ),

            SizedBox(height: 20),

            //Drop Down menu
            Container(
              width: 325,
              child: DropdownButton(
                hint: Text(
                  " I am a...                                                            ", /*textAlign: TextAlign.center*/
                ),
                value: selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
                items: occupation.map((occupation) {
                  return DropdownMenuItem(
                      child: new Text(occupation), value: occupation);
                }).toList(),
              ),
            ),

            SizedBox(height: 20),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                onPressed: () {
                  if (selectedLocation == 'Student') {
                    Navigator.of(context).pushNamed(StudentTabs.routeName);
                  } else if (selectedLocation == 'Donor') {
                    Navigator.of(context).pushNamed(DonorTabs.routeName);
                    // print('Donor selected');
                  } else {
                    // Error message displayed
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            //Forgot Password button
            /*FlatButton(
              onPressed: (){},
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),*/

            SizedBox(height: 130),

            Container(
              child: Column(
                children: <Widget>[
                  Text("Don't have an account?"),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Register.routeName);
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // This is just for test purposes
            Container(
              child: RaisedButton(
                child: Text('Sign in anon'),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  (result == null)
                      ? print('Error signing in')
                      : print('Signed in');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
