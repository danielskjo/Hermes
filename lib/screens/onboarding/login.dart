import 'package:flutter/material.dart';

import '../../services/auth.dart';

import '../student/student_tabs.dart';
import '../donor/donor_tabs.dart';
import './register.dart';

// Widgets
import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String error = '';

  List<String> occupation = [
    "Student",
    "Donor",
  ];
  String selectedLocation;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Logo(
                      150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 0,
                        bottom: 15,
                      ),
                      child: Center(
                        child: Text(
                          "DSC Project",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 0,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your email' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 0,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your password' : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          hintText: "Password",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (result == null) {
                              setState(() {
                                error = 'Please check your email and password.';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
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

                    // SizedBox(height: 130),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("Don't have an account?"),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Register.routeName);
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
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(StudentTabs.routeName);
                          },
                          child: Text(
                            "Go to student",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(DonorTabs.routeName);
                          },
                          child: Text(
                            "Go to donor",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
