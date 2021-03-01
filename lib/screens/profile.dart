import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import '../services/auth.dart';
import '../services/database.dart';

// Widgets
import '../widgets/graphics.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _nextFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String role;
  String imageUrl;
  String uid;

  String error = '';

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
  void initState() {
    super.initState();
    fetchUserID();
    fetchUserData();
  }

  fetchUserID() {
    uid = FirebaseAuth.instance.currentUser.uid;
  }

  void fetchUserData() async {
    dynamic user = await DatabaseService()
        .getUserData(FirebaseAuth.instance.currentUser.uid);

    if (user == null) {
      setState(() {
        _usernameController.text = "Username";
        _emailController.text = "Email";
        _universityController.text = "University";
        _addressController.text = "Address";
        _passwordController.text = "Password";
        imageUrl = 'Image';
        role = "student";
      });
    } else {
      setState(() {
        _usernameController.text = user.get(FieldPath(['username']));
        _emailController.text = user.get(FieldPath(['email']));
        _universityController.text = user.get(FieldPath(['university']));
        _addressController.text = user.get(FieldPath(['address']));
        _passwordController.text = user.get(FieldPath(['password']));
        imageUrl = user.get(FieldPath(['imageUrl']));
        role = user.get(FieldPath(['role']));
      });
    }
  }

  updateUserData(
    String uid,
    String username,
    String email,
    String university,
    String address,
    String password,
    String imageUrl,
  ) async {
    await DatabaseService().updateUser(
      uid,
      username,
      email,
      university,
      address,
      password,
      imageUrl,
    );
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // App Bar
    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Profile',
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  'Delete account?',
                ),
                content: Text(
                  'This will permanently delete your account.',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'No',
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Yes',
                    ),
                    onPressed: () {
                      _auth.deleteUser();

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await _auth.logout();
          },
        ),
      ],
    );

    final Container buildProfile = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.85,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
        child: profilePage(context),
      ),
    );

    final pageBody = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: buildProfile,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget profilePage(BuildContext context) {
    return SingleChildScrollView(
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
                          radius: 100.0,
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
                                      Icons.camera_alt_outlined,
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
          SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            'Username',
                          ),
                        ),
                        Expanded(
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
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            'Email',
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
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
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  role == 'student'
                      ? Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'University',
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _universityController,
                                  validator: (val) => val.isEmpty
                                      ? 'Enter your university'
                                      : null,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 15,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Address',
                                ),
                              ),
                              Expanded(
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
                                  right: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            'Password',
                          ),
                        ),
                        Expanded(
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
                              onFieldSubmitted: (_) async {
                                if (_formKey.currentState.validate()) {
                                  final usernameValid = await DatabaseService()
                                      .checkUsername(_usernameController.text);

                                  final emailValid = await DatabaseService()
                                      .checkEmail(_emailController.text);

                                  dynamic user = await DatabaseService()
                                      .getUserData(FirebaseAuth
                                          .instance.currentUser.uid);

                                  if (user.get(FieldPath(['username'])) !=
                                          _usernameController.text &&
                                      !usernameValid) {
                                    setState(() {
                                      error = 'Username is taken';
                                    });
                                  } else if (user.get(FieldPath(['email'])) !=
                                          _usernameController.text &&
                                      !emailValid) {
                                    setState(() {
                                      error = 'Email is taken';
                                    });
                                  } else {
                                    submitAction(context);
                                  }
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                          ),
                        )
                      ],
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
                          final usernameValid = await DatabaseService()
                              .checkUsername(_usernameController.text);

                          final emailValid = await DatabaseService()
                              .checkEmail(_emailController.text);

                          dynamic user = await DatabaseService().getUserData(
                              FirebaseAuth.instance.currentUser.uid);

                          if (user.get(FieldPath(['username'])) !=
                                  _usernameController.text &&
                              !usernameValid) {
                            setState(() {
                              error = 'Username is taken';
                            });
                          } else if (user.get(FieldPath(['email'])) !=
                                  _usernameController.text &&
                              !emailValid) {
                            setState(() {
                              error = 'Email is taken';
                            });
                          } else {
                            submitAction(context);
                          }
                        }
                      },
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  submitAction(BuildContext context) async {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: Text("Profile updated"),
        duration: Duration(seconds: 2),
      ),
    );
    updateUserData(
      uid,
      _usernameController.text,
      _emailController.text,
      _universityController.text,
      _addressController.text,
      _passwordController.text,
      imageUrl,
    );
  }
}
