import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/Welcomepage.dart';

class ResultPage extends StatefulWidget {
  int score;
  User user;
  ResultPage(this.score, this.user);

  @override
  _ResultPageState createState() => _ResultPageState(user, score);
}

class _ResultPageState extends State<ResultPage> {
  User user;
  int score;
  _ResultPageState(this.user, this.score);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async=>false,
          child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
              centerTitle: true,
              elevation: 5,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              title: Container(
                padding: EdgeInsets.only(top: 0.01225*height),
                child:
                    Text("Results !", style: simple(height), textAlign: TextAlign.center),
              ),
              leading: FlatButton(
                onPressed: gotowelcome,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: pinkey,
                ),
              )),
          body: Scaffold(
            body: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.1157*width, 0.06127*height, 0.1157*width, 0.03676*height),
                    child: new Text(
                      "Your Score is : $score",
                      style: new TextStyle(fontSize: 0.04289*height),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),
                  Container(
                    height: 0.1225*height,
                    width: width-10,
                    child: Image.asset('Images/rrib.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  gotowelcome(){
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return QuizPage(user);
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }
}
