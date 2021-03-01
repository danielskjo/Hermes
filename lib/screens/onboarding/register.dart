import 'dart:io';

import 'package:csulb_dsc_2021/services/database.dart';

import '../../services/helper/helperFunctions.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

import '../../services/auth.dart';

import '../loading.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  List<String> occupation = [
    "Student",
    "Donor",
  ];
  String selectedLocation = 'Student';

  final _emailFocusNode = FocusNode();
  final _nextFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _password2FocusNode = FocusNode();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                'Discard information?',
              ),
              content: Text(
                'Changes will not be saved.',
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'No',
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'Yes',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
      title: Text(
        'Register',
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
                    Container(
                      height: 120,
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 20, bottom: 0),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor: Colors.blue,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      width: 35,
                                      height: 35,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.add_a_photo,
                                                size: 20,
                                              ),
                                              onPressed: getImage,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 20,
                          right: 20,
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              selectedLocation = newValue;
                              print(selectedLocation);
                            });
                          },
                          items: occupation.map((occupation) {
                            return DropdownMenuItem(
                              child: new Text(occupation),
                              value: occupation,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
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
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 0,
                      ),
                      child: selectedLocation == 'Student'
                          ? TextFormField(
                              controller: _emailController,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "School Email",
                                hintText: "School Email",
                              ),
                              focusNode: _emailFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_nextFocusNode);
                              },
                            )
                          : TextFormField(
                              controller: _emailController,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                                hintText: "Email",
                              ),
                              focusNode: _emailFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_nextFocusNode);
                              },
                            ),
                    ),
                    selectedLocation == 'Student'
                        ? Padding(
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
                              focusNode: _nextFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                          )
                        : Padding(
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
                                labelText: "Address (Optional)",
                                hintText: "Address (Optional)",
                              ),
                              focusNode: _nextFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
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
                        focusNode: _passwordFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_password2FocusNode);
                        },
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
                        focusNode: _password2FocusNode,
                        onFieldSubmitted: (_) async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            final usernameValid = await DatabaseService()
                                .checkUsername(_usernameController.text);

                            final emailValid = await DatabaseService()
                                .checkEmail(_emailController.text);

                            if (!usernameValid) {
                              setState(() {
                                error = 'Username is taken';
                                loading = false;
                              });
                            } else if (!emailValid) {
                              setState(() {
                                error = 'Email already used';
                                loading = false;
                              });
                            } else {
                              dynamic result;

                              if (selectedLocation == 'Student') {
                                result = await _auth.register(
                                  _usernameController.text,
                                  _emailController.text,
                                  _universityController.text,
                                  null,
                                  _passwordController.text,
                                  'Image placeholder',
                                  'student',
                                );
                              } else {
                                result = await _auth.register(
                                  _usernameController.text,
                                  _emailController.text,
                                  null,
                                  _addressController.text,
                                  _passwordController.text,
                                  'Image placeholder',
                                  'donor',
                                );
                              }

                              if (result == null) {
                                setState(() {
                                  error = 'Please enter a valid email';
                                  loading = false;
                                });
                              } else {
                                HelperFunctions().saveUserEmail(
                                    userEmail: _emailController.text);
                                HelperFunctions().saveUserName(
                                    userName: _usernameController.text);
                                HelperFunctions()
                                    .saveUserLoggedIn(isUserLoggedIn: true);

                                Navigator.of(context).pop();
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10,
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
                            final usernameValid = await DatabaseService()
                                .checkUsername(_usernameController.text);

                            final emailValid = await DatabaseService()
                                .checkEmail(_emailController.text);

                            if (!usernameValid) {
                              setState(() {
                                error = 'Username is taken';
                                loading = false;
                              });
                            } else if (!emailValid) {
                              setState(() {
                                error = 'Email already used';
                                loading = false;
                              });
                            } else {
                              dynamic result;

                              if (selectedLocation == 'Student') {
                                result = await _auth.register(
                                  _usernameController.text,
                                  _emailController.text,
                                  _universityController.text,
                                  null,
                                  _passwordController.text,
                                  'Image placeholder',
                                  'student',
                                );
                                HelperFunctions().saveUserRole(userRole: 'student');
                              } else {
                                result = await _auth.register(
                                  _usernameController.text,
                                  _emailController.text,
                                  null,
                                  _addressController.text,
                                  _passwordController.text,
                                  'Image placeholder',
                                  'donor',
                                );
                                HelperFunctions().saveUserRole(userRole: 'donor');
                              }

                              if (result == null) {
                                setState(() {
                                  error = 'Please enter a valid email';
                                  loading = false;
                                });
                              } else {
                                HelperFunctions().saveUserEmail(
                                    userEmail: _emailController.text);
                                HelperFunctions().saveUserName(
                                    userName: _usernameController.text);
                                HelperFunctions()
                                    .saveUserLoggedIn(isUserLoggedIn: true);

                                Navigator.of(context).pop();
                              }
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
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}
