import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import '../models/student.dart';
import '../models/donor.dart';

// Widgets
import '../widgets/graphics.dart';
import '../services/auth.dart';

class User {
  String id;
  String name;
  String username;
  String email;
  String password;
  String image;
  String type;
  String university;
  String address;

  User.student(Student user) {
    id = user.id;
    name = user.name;
    username = user.username;
    email = user.email;
    password = user.password;
    image = user.image;
    university = user.university;
    type = "Student";
  }

  User.donor(Donor user) {
    id = user.id;
    name = user.name;
    email = user.email;
    username = user.username;
    password = user.password;
    image = user.image;
    address = user.address;
    type = "Donor";
  }
}

class Profile extends StatefulWidget {
  final String userType;
  const Profile({Key key, this.userType}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;

  final AuthService _auth = AuthService();

  @override
  void initState() {
    if (widget.userType == "Student") {
      Student studentUser = new Student('1', 'First Last', 'Username123',
          'address@gmail.com', '123456', 'blank', 'CSULB');
      user = new User.student(studentUser);
    } else {
      Donor donorUser = new Donor('1', 'First Last', 'Username123',
          'address@gmail.com', '123456', 'blank', '1234 Long Street');
      user = new User.donor(donorUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    String userDependent;

    if (widget.userType == "Student") {
      userDependent = "University";
    } else {
      userDependent = "Address";
    }

    double width = MediaQuery.of(context).size.width;

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
                Padding(padding: const EdgeInsets.only(right: 15),)
              ],
            ),
            SizedBox(height: 20),
            ConstructProfileField(context, "Username"),
            SizedBox(height: 10),
            ConstructProfileField(context, "Password"),
            SizedBox(height: 10),
            ConstructProfileField(context, "Email"),
            SizedBox(height: 10),
            ConstructProfileField(context, userDependent),
          ],
        ),
      ),
    );
  }

  Widget ConstructProfileField(BuildContext context, String field) {
    bool _enableObfuscate = false;
    String text;
    String title;

    double width = MediaQuery.of(context).size.width;

    switch (field) {
      case "Username":
        text = user.username;
        title = "Username";
        break;
      case "Password":
        _enableObfuscate = true;
        title = "Password";
        text = user.password;
        break;
      case "Email":
        title = "Email";
        text = user.email;
        break;
      case "Address":
        title = "Address";
        text = user.address;
        break;
      case "University":
        text = user.university;
        title = "University";
        break;
      default:
        text = "NULL";
        title = "NULL";
        break;
    }

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 15),
          width: 100,
          child: Text(title),
        ),
        Expanded(
          child: TextField(
            readOnly: false,
            obscureText: _enableObfuscate,
            controller: TextEditingController(text: text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
        )
      ],
    );
  }
}
