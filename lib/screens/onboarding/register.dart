import "package:flutter/material.dart";
import "../student/student_register.dart";
import "../donor/donor_register.dart";

class Register extends StatefulWidget {
  static const routeName = '/register';
  RegisterState createState() => RegisterState();
}
  
class RegisterState extends State<Register> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

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
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Register as a",
              style: TextStyle(
                fontSize: 26,
              )
            ),
          ),

          SizedBox(height: 50),

          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),

            child: FlatButton(
              onPressed: (){
                Navigator.of(context).pushNamed(StudentRegister.routeName);
              },
              child: Text(
                "Student",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),

          SizedBox(height: 30),
          Text("or", style: TextStyle(fontSize: 20)),
          SizedBox(height: 30),

          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),

            child: FlatButton(
              onPressed: (){
                Navigator.of(context).pushNamed(DonorRegister.routeName);
              },
              child: Text(
                "Donor",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}