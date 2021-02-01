import "package:flutter/material.dart";

class Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border(
          top: BorderSide(
              width: 2, color: Colors.black),
          left: BorderSide(
              width: 2, color: Colors.black),
          right: BorderSide(
              width: 2, color: Colors.black),
          bottom: BorderSide(
              width: 2, color: Colors.black),
        )
      ),
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Image(
            image: AssetImage(
              "assets/img/logo.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class ProjectTitle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 15),
      child: Center(
        child: Text("DSC Project", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  SmallLogo(this.size);

  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.only(left: 15),
      child: Image(
        image: AssetImage(
        "assets/img/logo_inverted.png",
        ),
        fit: BoxFit.contain,
      ),
    );
  }
}