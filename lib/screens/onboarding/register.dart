import 'dart:io';

import 'package:csulb_dsc_2021/services/database.dart';
import 'package:csulb_dsc_2021/services/helper/constants.dart';

import '../../services/helper/helperFunctions.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  List<String> role = [
    "Student",
    "Donor",
  ];
  String selectedRole = 'Student';

  String imageUrl;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _nextFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _password2FocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Register',
      ),
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
                                Icons.add_a_photo,
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

    final dropdownMenu = Padding(
      padding: const EdgeInsets.only(
        top: 5,
        left: 20,
        right: 20,
      ),
      child: DropdownButton(
        isExpanded: true,
        value: selectedRole,
        onChanged: (val) {
          setState(() {
            selectedRole = val;
          });
        },
        items: role.map((role) {
          return DropdownMenuItem(
            child: new Text(role),
            value: role,
          );
        }).toList(),
      ),
    );

    final usernameField = Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 0,
      ),
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
    );

    final emailField = Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 0,
      ),
      child: selectedRole == 'Student'
          ? TextFormField(
              controller: _emailController,
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "School Email",
                hintText: "School Email",
              ),
              focusNode: _emailFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_nextFocusNode);
              },
            )
          : TextFormField(
              controller: _emailController,
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
    );

    final uniField = Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 0,
      ),
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
    );

    final addressField = Padding(
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
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      ),
    );

    final passwordField = Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 0,
      ),
      child: TextFormField(
        controller: _passwordController,
        validator: (val) =>
            val.length < 6 ? 'Enter a password that is 6+ chars long' : null,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Password",
          hintText: "Password",
        ),
        focusNode: _passwordFocusNode,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_password2FocusNode);
        },
      ),
    );

    final password2Field = Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 20,
        bottom: 0,
      ),
      child: TextFormField(
        controller: _password2Controller,
        validator: (val) =>
            val != _passwordController.text ? 'Passwords do not match' : null,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Confirm Password",
          hintText: "Confirm Password",
        ),
        focusNode: _password2FocusNode,
        onFieldSubmitted: (_) {
          submitAction();
        },
      ),
    );

    final errorText = Text(
      error,
      style: TextStyle(color: Colors.red, fontSize: 14.0),
    );

    final registerButton = Container(
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
          submitAction();
        },
        child: Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );

    final pageBody = SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            profilePicture,
            dropdownMenu,
            usernameField,
            emailField,
            selectedRole == 'Student' ? uniField : addressField,
            passwordField,
            password2Field,
            SizedBox(
              height: 10,
            ),
            errorText,
            SizedBox(
              height: 10,
            ),
            registerButton,
          ],
        ),
      ),
    );

    return loading
        ? Loading()
        : Scaffold(
            appBar: appBar,
            body: pageBody,
          );
  }

  submitAction() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      final usernameValid =
          await DatabaseService().checkUsername(_usernameController.text);

      final emailValid =
          await DatabaseService().checkEmail(_emailController.text);

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

        if (selectedRole == 'Student') {
          result = await _auth.register(
            _usernameController.text,
            _emailController.text,
            _universityController.text,
            null,
            _passwordController.text,
            imageUrl,
            'student',
          );
        } else {
          result = await _auth.register(
            _usernameController.text,
            _emailController.text,
            null,
            _addressController.text,
            _passwordController.text,
            imageUrl,
            'donor',
          );
        }

        if (result == null) {
          setState(() {
            error = 'Please enter a valid email';
            loading = false;
          });
        } else {
          print('setting constant username');
          Constants.myUserName = result['username'];
          print('myusername = ' + Constants.myUserName);

          Navigator.of(context).pop();
        }
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
