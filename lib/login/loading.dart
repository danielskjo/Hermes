import 'package:flutter/material.dart';

import './login.dart';

class Loading extends StatefulWidget {
  static const routeName = '/loading';

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background
            new Container(
              decoration: BoxDecoration(color: Colors.white),
            ),

            /// Render the background image
            ///
            /// Red circle
            new Container(
              margin: EdgeInsets.all(100),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),

            /// Render the Title widget, loader and messages below each other
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            child: Text("To login screen"),
                            onPressed: () {
                              Navigator.of(context).pushNamed(Login.routeName);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "App",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(width: 100),
                              Text(
                                "Title",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "App",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(width: 100),
                              Text(
                                "Subtitle",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),

                      /// Loader Animation Widget
                      /*CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green),
                    ),*/
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                      ),
                      //Text("Loading"), //Loading text
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
