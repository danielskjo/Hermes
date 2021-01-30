import 'package:csulb_dsc_2021/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../../services/auth.dart';

import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';

class StudentRegister extends StatefulWidget {
  static const routeName = '/student-register';

  @override
  StudentRegisterState createState() => StudentRegisterState();
}

class StudentRegisterState extends State<StudentRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  // TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: SmallLogo(
        50,
      ),
      title: Text(
        'Register as a Student',
      ),
    );

    return loading
        ? Loading()
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 15,
                    //     right: 15,
                    //     top: 20,
                    //     bottom: 0,
                    //   ),
                    //   child: TextFormField(
                    //     controller: _nameController,
                    //     validator: (val) =>
                    //         val.isEmpty ? 'Enter your name' : null,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: "Name",
                    //       hintText: "Name",
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter a username' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          hintText: "Username",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "School Email",
                          hintText: "School Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _universityController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your university' : null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "University",
                          hintText: "University",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (val) => val.length < 6
                            ? 'Enter a password that is 6+ chars long'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _password2Controller,
                        validator: (val) => val != _passwordController.text
                            ? 'Passwords do not match'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm Password",
                          hintText: "Confirm Password",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 20,
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
                            dynamic result = await _auth.register(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (result == null) {
                              setState(() {
                                error = 'Please enter a valid email';
                                loading = false;
                              });
                            } else {
                              User updateUser =
                                  FirebaseAuth.instance.currentUser;
                              updateUser.updateProfile(
                                  displayName: _usernameController.text);
                              userSetup(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                                _universityController.text,
                                null,
                                'Image placeholder',
                                true,
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
