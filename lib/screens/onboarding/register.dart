import 'file:///C:/Users/kevin/Desktop/flutter/csulb-dsc-2021/lib/services/helper/helperFunctions.dart';
import "package:flutter/material.dart";

import '../../services/auth.dart';

import '../../widgets/graphics.dart';
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

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

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
                                                    width: 2,
                                                    color: Colors.black),
                                                left: BorderSide(
                                                    width: 2,
                                                    color: Colors.black),
                                                right: BorderSide(
                                                    width: 2,
                                                    color: Colors.black),
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                              icon: Icon(
                                                  Icons.camera_alt_outlined,
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
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
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

                              HelperFunctions.saveUserEmailSharedPreference(_emailController.text);
                              HelperFunctions.saveUserNameSharedPreference(_usernameController.text);
                              HelperFunctions.saveUserLoggedInSharedPreference(true);

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
