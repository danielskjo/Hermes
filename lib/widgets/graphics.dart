import "package:flutter/material.dart";

class Logo extends StatelessWidget {
  Logo(this.size);
  
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(
        image: AssetImage(
        "assets/img/logo.png",
        ),
        fit: BoxFit.fill,
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
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 150,
            child: Icon(
              Icons.favorite,
              color: Colors.pink,
              size: size,
            ),
          ),
        ),
        Center(
          child: Container(
            width: 200,
            height: 150,
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: size/3,
            ),
          ),
        ),
      ],
    );
  }
}