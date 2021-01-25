import 'package:flutter/material.dart';

class LoginAfterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },

          child: Text("Test"),
        ),
      ),
    );
  }
}