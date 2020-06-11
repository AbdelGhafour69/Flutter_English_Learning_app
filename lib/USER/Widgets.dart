import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/USER/Profile.dart';
import 'package:quiz/USER/Quizesbycategory.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/login.dart';
import 'package:quiz/USER/tabs.dart';

class CardList extends StatelessWidget {
  User user;
  CardList(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: ListView(
        children: <Widget>[GreetingCard(user), TextToSpeachCard()],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class TextToSpeachCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(height);
    print(0.245 * height);
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      margin: EdgeInsets.only(left: 0, right: 0.02314 * width),
      child: Container(
        height: 0.245 * height,
        width: 0.8796 * width,
        decoration: BoxDecoration(
          color: orangey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 0.0735 * height, left: 0.069 * width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Learn With Media ?",
                style: title(height),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                onPressed: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Quiztab(),
                  ),
                ),
                child: Text("Go"),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrangeCard extends StatelessWidget {
  User user;
  OrangeCard(this.user);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 0.1368 * height,
      margin: EdgeInsets.only(left: 0.0462 * width, right: 0.0462 * width),
      decoration: BoxDecoration(
        color: pinkey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            Container(
              height: 0.08508 * height,
              width: 0.2777 * width,
              decoration: BoxDecoration(
                color: greeny,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            Positioned(
              left: 0.55555 * width,
              child: Container(
                alignment: Alignment.topCenter,
                height: 0.1593 * height,
                width: 0.324 * width,
                decoration: BoxDecoration(
                  color: orangey,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 0.0245 * height, left: 0.02777),
                  child: ButtonTheme(
                    height: 0.049019 * height,
                    minWidth: 0.09259 * width,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      color: move,
                      elevation: 9,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 0.0367 * height,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new QuizCategories(user),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.03876 * height,
              left: 0.0694 * width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "English Quiz !",
                    style: title(height),
                  ),
                  SizedBox(
                    height: 0.01225 * height,
                  ),
                  Text(
                    "Play our quizes now! ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GreetingCard extends StatelessWidget {
  User user;
  GreetingCard(this.user);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      margin: EdgeInsets.only(left: 0.0231 * width, right: 0.0361 * width),
      child: Container(
        height: 0.2509 * height,
        width: 0.8796 * width,
        decoration: BoxDecoration(
          color: move,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 0.0535 * height, left: 0.0694 * width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome " + user.prenom + "\nHow Are you?",
                style: title(height),
              ),
              SizedBox(
                height: 0.01225 * height,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                onPressed: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Profile(user),
                  ),
                ),
                child: Text("View Profile"),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Myappbar extends StatefulWidget {
  @override
  _MyappbarState createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      centerTitle: true,
      elevation: 5,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      leading: FlatButton(
        onPressed: () => backtologin(),
        child: Icon(
          Icons.arrow_back_ios,
          color: pinkey,
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(top: 0.0067 * height),
        child: Text("Quiz App",
            style: simple(height), textAlign: TextAlign.center),
      ),
    );
  }

  backtologin(){
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return LoginScreen();
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
