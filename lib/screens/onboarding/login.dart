import 'package:flutter/material.dart';

import '../authenticate/auth.dart';

import '../student/student_tabs.dart';
import '../donor/donor_tabs.dart';
import '../onboarding/register.dart';

// Widgets
import '../../widgets/graphics.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();
  bool _enableButton = false;

  List<String> occupation = ["Student", "Donor"];
  String selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Logo(150),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 0, bottom: 15),
                child: Center(
                    child: Text("DSC Project",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26))),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 0, bottom: 0),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "User",
                    hintText: "User",
                    fillColor: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 0, bottom: 0),
                child: TextField(
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password",
                    fillColor: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20),

              //Drop Down menu

              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropdownButton(
                    hint: Text(
                      " I am a...", /*textAlign: TextAlign.center*/
                    ),
                    isExpanded: true,
                    value: selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        selectedLocation = newValue;
                        _enableButton = true;
                      });
                    },
                    items: occupation.map((occupation) {
                      return DropdownMenuItem(
                          child: new Text(occupation), value: occupation);
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: _enableButton ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                  // onPressed: _enableButton ? () => routeLogin() : null,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),

              // This is just for test purposes
              Container(
                child: RaisedButton(
                  child: Text('Sign in anon'),
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('Error signing in');
                    } else {
                      print('Signed in');
                      print(result.uid);
                    }
                  },
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

              // SizedBox(height: 130),
              SizedBox(height: 100),

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
            ],
          ),
        ),
      ),
    );
  }

  void routeLogin() {
    if (selectedLocation == 'Student') {
      Navigator.of(context).pushNamed(StudentTabs.routeName);
    } else if (selectedLocation == 'Donor') {
      Navigator.of(context).pushNamed(DonorTabs.routeName);
      // print('Donor selected');
    } else {
      // Error message displayed
    }
  }
}
