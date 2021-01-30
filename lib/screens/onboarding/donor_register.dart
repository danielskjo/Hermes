import 'package:csulb_dsc_2021/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../../services/auth.dart';

import '../../widgets/graphics.dart';
import '../../widgets/loading.dart';

class DonorRegister extends StatefulWidget {
  static const routeName = '/student-register';

  @override
  DonorRegisterState createState() => DonorRegisterState();
}

class DonorRegisterState extends State<DonorRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: SmallLogo(
        50,
      ),
      title: Text(
        'Register as a Donor',
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
                          labelText: "Email",
                          hintText: "Email",
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Address",
                          hintText: "Address (Optional)",
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
                                  null,
                                  _addressController.text,
                                  'Image placeholder',
                                  false,
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
