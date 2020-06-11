import 'package:flutter/material.dart';

class GridTwo extends StatefulWidget {
  @override
  _GridTwoState createState() => _GridTwoState();
}

class _GridTwoState extends State<GridTwo> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: new GridView.count(
        crossAxisCount: 1,
        children: <Widget>[
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "Images/dog.jpg",
                    height: 0.3676 * height,
                    width: 0.9259 * width,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\Dog",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Container(
              child: new Card(
                  elevation: 10.0,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "Images/cat.jpg",
                        height: 0.3676 * height,
                        width: 0.9259 * width,
                        fit: BoxFit.cover,
                      ),
                      new SizedBox(
                        height: 5.0,
                      ),
                      new Text(
                        "\Cat",
                        style: TextStyle(
                          fontSize: 0.03676 * height,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ))),
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: new Image.asset(
                      "Images/lion.jpg",
                      height: 0.3676 * height,
                      width: 0.9259 * width,
                      fit: BoxFit.contain,
                    ),
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\Lion",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "Images/monkey.jpg",
                    height: 0.3676 * height,
                    width: 0.9259 * width,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\Monkey",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "Images/tiger.jpg",
                    height: 0.3676 * height,
                    width: 0.9259 * width,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\Tiger",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "Images/panda.jpg",
                    height: 0.3676 * height,
                    width: 0.9259 * width,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\Panda",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          new Container(
            child: new Card(
              elevation: 10.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    "Images/elephant.jpg",
                    height: 0.3676 * height,
                    width: 0.9259 * width,
                    fit: BoxFit.cover,
                  ),
                  new SizedBox(
                    height: 5.0,
                  ),
                  new Text(
                    "\elephant",
                    style: TextStyle(
                      fontSize: 0.03676 * height,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
