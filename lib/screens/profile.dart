import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';

import '../services/database.dart';

// Widgets
import '../widgets/graphics.dart';
import '../services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String role;
  String imageUrl;
  String uid;

  @override
  void initState() {
    super.initState();
    fetchUserID();
    fetchUserData();
  }

  fetchUserID() {
    uid = FirebaseAuth.instance.currentUser.uid;
    print(uid);
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
    // App Bar
    final AppBar appBar = AppBar(
      leading: SmallLogo(50),
      title: Text(
        'My Profile',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await _auth.logout();
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
                            Icon(
                              Icons.account_circle_outlined,
                              size: 100,
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
                                        border: Border(
                                          top: BorderSide(
                                              width: 2, color: Colors.black),
                                          left: BorderSide(
                                              width: 2, color: Colors.black),
                                          right: BorderSide(
                                              width: 2, color: Colors.black),
                                          bottom: BorderSide(
                                              width: 2, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        icon: Icon(Icons.camera_alt_outlined,
                                            size: 20),
                                        onPressed: () {},
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
                height: 300,
                child: Form(
                  key: GlobalKey<FormState>(),
                  child: Column(
                    children: <Widget>[
                      userProfileField(
                        "Username",
                        _usernameController,
                        false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      userProfileField(
                        "Email",
                        _emailController,
                        false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      role == 'student'
                          ? userProfileField(
                              "University", _universityController, false)
                          : userProfileField(
                              "Address", _addressController, false),
                      SizedBox(
                        height: 10,
                      ),
                      userProfileField("Password", _passwordController, true),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            top: BorderSide(width: 2, color: Colors.grey),
                            left: BorderSide(width: 2, color: Colors.grey),
                            right: BorderSide(width: 2, color: Colors.grey),
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          ),
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            submitAction(context);
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    top: BorderSide(width: 2, color: Colors.grey),
                    left: BorderSide(width: 2, color: Colors.grey),
                    right: BorderSide(width: 2, color: Colors.grey),
                    bottom: BorderSide(width: 2, color: Colors.grey),
                  ),
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                child: FlatButton(
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _deleteUserDialog(
                          context,
                          "Are you sure you would like to delete your account? This is a final action. (Hold \"Delete Account\" to confirm)"),
                    );
                  },
                ),
              ),
              Spacer(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfileField(
      String fieldName, TextEditingController controller, bool obscure) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              fieldName,
            ),
          ),
          Expanded(
            child: TextField(
              obscureText: obscure,
              controller: controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _deleteUserDialog(BuildContext context, String message) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Cancel'),
        ),
        new FlatButton(
          onPressed: () {},
          onLongPress: () {
            _auth.deleteUser();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Delete Account'),
        ),
      ],
    );
  }

  submitAction(BuildContext context) {
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
