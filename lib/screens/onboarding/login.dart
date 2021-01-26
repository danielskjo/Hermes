import 'package:flutter/material.dart';

import '../student/student_tabs.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>
          [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Icon(
                    Icons.headset_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "User",
                  hintText: "User",
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Password",
                ),
              ),
            ),

            SizedBox(height: 20),

           DropdownButton<String>(
             items: <String>["Student", "Donor"].map((String value) {
               return new DropdownMenuItem<String>(
                 value: value,
                 child: new Text(value),
               );
             }).toList(),
           ),

            FlatButton(
              onPressed: (){},
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
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
                  Navigator.of(context).pushNamed(StudentTabs.routeName);
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            SizedBox(height: 130),

            Text('New User? Create Account')
          ],
        ),
      ),
        
    );
  }
}
