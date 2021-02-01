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

  void initState() {
    fetchUser();
    super.initState();
  }

  fetchUser() async {
    dynamic user = await DatabaseService()
        .getUserData(FirebaseAuth.instance.currentUser.uid);

    if (user == null) {
      print('Unable');
    } else {
      setState(() {
        _usernameController.text = user.get(FieldPath(['username']));
        _emailController.text = user.get(FieldPath(['email']));
        _universityController.text = user.get(FieldPath(['university']));
        _addressController.text = user.get(FieldPath(['address']));
        _passwordController.text = user.get(FieldPath(['password']));
        role = user.get(FieldPath(['role']));
      });
    }
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
          icon: Icon(Icons.save),
          onPressed: () {
            // Update user data
            // DatabaseService()
            //     .getUserData(FirebaseAuth.instance.currentUser.uid)
            //     .then((snapshot) {
            //   dynamic username = snapshot.get(FieldPath(['username']));
            //   dynamic email = snapshot.get(FieldPath(['email']));
            //   print(username);
            //   print(email);
            // });
            print(_usernameController.text);
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

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
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
            SizedBox(
              height: 20,
            ),
            constructProfileField(
              context,
              "Username",
              _usernameController.text,
              false,
            ),
            SizedBox(
              height: 10,
            ),
            constructProfileField(
              context,
              "Email",
              _emailController.text,
              false,
            ),
            SizedBox(
              height: 10,
            ),
            role == 'student'
                ? constructProfileField(
                    context,
                    'University',
                    _universityController.text,
                    false,
                  )
                : constructProfileField(
                    context,
                    'Address',
                    _addressController.text,
                    false,
                  ),
            SizedBox(
              height: 10,
            ),
            constructProfileField(
              context,
              "Password",
              _passwordController.text,
              true,
            ),
            SizedBox(
              height: 150,
            ),
            FlatButton(
              child: Text(
                'Delete User',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () => _auth.deleteUser(),
            ),
          ],
        ),
      ),
    );
  }

  Widget constructProfileField(
      BuildContext context, String fieldName, String userField, bool obscure) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 15),
          width: 100,
          child: Text(fieldName),
        ),
        Expanded(
          child: TextField(
            readOnly: true,
            obscureText: obscure,
            controller: TextEditingController(text: userField),
            onTap: () {
              // Will route to edit page later
              String text = "Edit " + fieldName;
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(text), duration: Duration(seconds: 1)));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
        )
      ],
    );
  }
}
