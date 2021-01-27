import "package:flutter/material.dart";

class StudentRegister extends StatefulWidget {
  static const routeName = '/student-register';
  @override
  StudentRegisterState createState() => StudentRegisterState();
}
  
class StudentRegisterState extends State<StudentRegister> {
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      leading: FlutterLogo(),
      title: Text(
        'Register as a Student',
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
                  labelText: "School Email",
                  hintText: "School Email",
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "University",
                  hintText: "University",
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
                  // Route to next?
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}