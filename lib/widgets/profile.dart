import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  final String userType;
  const Profile ({ Key key, this.userType }): super(key: key);
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  User user = new User.student('1','First Last','Username123','address@gmail.com','123456','blank','CSULB');

  @override
  Widget build(BuildContext context) {

    String userDependent;

    if (user.type == "Student") {
      userDependent = "University";
    }
    else {
      userDependent = "Address";
    }

    double width = MediaQuery.of(context).size.width;
    

    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
      title: Text(
        'My Profile',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed : () {},
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.account_circle_outlined, size: 100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text(user.name, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.08)),
                    ),
                  ),
                ),
                Spacer(),
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
    Widget icon;

    double width = MediaQuery.of(context).size.width;

    switch(field) {
      case "Username":
        text = user.username;
        icon = Icon(Icons.account_circle_outlined);
        break;
      case "Password":
        _enableObfuscate = true;
        icon = Icon(Icons.lock_outline);
        text = user.password;
        break;
      case "Email":
        icon = Icon(Icons.email);
        text = user.email;
        break;
      case "Address":
        icon = Icon(Icons.home);
        text = user.address;
        break;
      case "University":
        text = user.university;
        icon = Icon(Icons.school);
        break;
      default:
        text = "NULL";
        icon = Icon(Icons.remove);
    }

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: icon,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            width: width * 0.7,
            child: TextField(
              readOnly: true,
              obscureText: _enableObfuscate,
              controller: TextEditingController(text: text),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
      ],
    );
  }
}