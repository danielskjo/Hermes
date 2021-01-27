import "package:flutter/material.dart";

class StudentRegister extends StatefulWidget {
  static const routeName = '/student-register';
  @override
  StudentRegisterState createState() => StudentRegisterState();
}
  
class StudentRegisterState extends State<StudentRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Student register page"),
    );
  }
}