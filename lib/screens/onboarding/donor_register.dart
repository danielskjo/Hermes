import "package:flutter/material.dart";
import '../donor/donor_tabs.dart';

class DonorRegister extends StatefulWidget {
  static const routeName = '/donor-register';
  
  @override
  DonorRegisterState createState() => DonorRegisterState();
}
  
class DonorRegisterState extends State<DonorRegister> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
      title: Text(
        'Register as a Donor',
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                  hintText: "Name",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                  hintText: "Username",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Email",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Address (Optional)",
                  hintText: "Address (Optional)",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Password",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                ),
              ),
            ),
            
            SizedBox(height: 20),

            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(DonorTabs.routeName);
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}