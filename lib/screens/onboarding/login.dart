import 'package:csulb_dsc_2021/routes/student/student_home.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD:lib/login/login.dart
import '../routes/student/student_tabs.dart';
//
=======
import '../student/student_tabs.dart';
>>>>>>> c7ca52ebc8d7434e5103c8490674ea067fc0ec24:lib/screens/onboarding/login.dart

class Login extends StatefulWidget {
  static const routeName = '/login';
  
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String dropDownValue = "I am a...";
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>
          [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  //child: Image.asset(""),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  hintText: "Username",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 5.0),
                  ),
                  labelText: "Password",
                  hintText: "Password",
                ),
              ),
            ),
          
            FlatButton(
              onPressed: (){}, 
              child: Text("Forgot Password",
              style: TextStyle(color: Colors.blue, fontSize: 15),
              )
            ),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(StudentHome.routeName);
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),

            SizedBox(height: 130),
            Text("New user? Create Account"),
          ],
        ),
      ),
    );
  }
}