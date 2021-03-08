import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  String imageUrl;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String role;
  String uid;

  final _emailFocusNode = FocusNode();
  final _nextFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String error = '';

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
    _auth.changeEmail(email);
    _auth.changePassword(password);
  }

  deleteAccountDialog() {
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
  }

  saveChanges() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Change profile details?',
        ),
        content: Text(
          'You will not be able to undo this action.',
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
              Navigator.of(ctx).pop();
              submitAction(context);
            },
          ),
        ],
      ),
    );
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
          onPressed: deleteAccountDialog,
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await _auth.logout();
          },
        ),
      ],
    );

    final profilePicture = Container(
      height: 120,
      child: Row(
        children: <Widget>[
          Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
            child: Container(
              width: 100,
              height: 100,
              child: Stack(
                children: <Widget>[
                  imageUrl != null
                      ? Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(imageUrl),
                            ),
                          ),
                        )
                      : Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/img/default.jpg')),
                          ),
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
                              onPressed: _pickImage,
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
    );

    final usernameField = Container(
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
              validator: (val) => val.isEmpty ? 'Enter a username' : null,
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
              right: 15,
            ),
          )
        ],
      ),
    );

    final emailField = Container(
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
                  EmailValidator.validate(val) ? null : 'Invalid email address',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Email",
              ),
              focusNode: _emailFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_nextFocusNode);
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
    );

    final universityField = Container(
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
              validator: (val) => val.isEmpty ? 'Enter your university' : null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "University",
                hintText: "University",
              ),
              focusNode: _nextFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
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
    );

    final addressField = Container(
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
                FocusScope.of(context).requestFocus(_passwordFocusNode);
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
    );

    final passwordField = Container(
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
                onFieldSubmitted: (_) {
                  saveChanges();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
          )
        ],
      ),
    );

    final saveChangesButton = Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: FlatButton(
        onPressed: saveChanges,
        child: Text(
          "Save Changes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );

    final Container buildProfile = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.85,
      padding: const EdgeInsets.only(bottom: 50),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              profilePicture,
              SizedBox(
                height: 30,
              ),
              Container(
                height: 400,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      usernameField,
                      SizedBox(
                        height: 10,
                      ),
                      emailField,
                      SizedBox(
                        height: 10,
                      ),
                      role == 'student' ? universityField : addressField,
                      SizedBox(
                        height: 10,
                      ),
                      passwordField,
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
                      saveChangesButton,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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

  submitAction(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final usernameValid =
          await DatabaseService().checkUsername(_usernameController.text);

      final emailValid =
          await DatabaseService().checkEmail(_emailController.text);

      dynamic user = await DatabaseService()
          .getUserData(FirebaseAuth.instance.currentUser.uid);

      if (user.get(FieldPath(['username'])) != _usernameController.text &&
          !usernameValid) {
        setState(() {
          error = 'Username is taken';
        });
      } else if (user.get(FieldPath(['email'])) != _emailController.text &&
          !emailValid) {
        setState(() {
          error = 'Email is taken';
        });
      } else {
        setState(() {
          error = '';
        });
        Scaffold.of(context).hideCurrentSnackBar();
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
  }

  _pickImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      var snapshot = await _storage
          .ref()
          .child('images/${DateTime.now()}.png')
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      print('downloadURL: ' + downloadUrl);

      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No path received');
    }
  }
}
