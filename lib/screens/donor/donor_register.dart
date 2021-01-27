import "package:flutter/material.dart";

class DonorRegister extends StatefulWidget {
  static const routeName = '/donor-register';
  @override
  DonorRegisterState createState() => DonorRegisterState();
}
  
class DonorRegisterState extends State<DonorRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Donor register page"),
    );
  }
}