import 'package:flutter/material.dart';
import 'package:quiz/ADMIN/aminlogin.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/USER/Register.dart';
import 'package:quiz/USER/loginForm.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 0.09259*width, right: 0.09259*width, top: 0.0245*height),
              constraints: BoxConstraints.expand(height: 0.49*height),
              decoration: BoxDecoration(
                color: textcolor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Knowledge is Power!",
                    style: title(height),
                  ),
                  SizedBox(
                    height: 0.0245*height,
                  ),
                  ButtonTheme(
                    height: 0.08578*height,
                    child: RaisedButton(
                      splashColor: orangey,
                      child: Text(
                        "Login",
                        style: title(height),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new Login(),
                        ),
                      ),
                      color: pinkey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03676*height,
                  ),
                  ButtonTheme(
                    height: 0.08578*height,
                    child: FlatButton(
                      child: Text(
                        "Register",
                        style: title(height),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new Register(),
                        ),
                      ),
                      color: pinkey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.01225*height,
                  ),
                  GestureDetector(
                    child: Text(
                      "Login as admin",
                      style: title(height),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new AdminLogin(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
              child: Container(
                child: Image.asset("assets/hh.png"),
                margin: EdgeInsets.only(top: 0.0367*height),
              ),
              alignment: Alignment.topCenter)
        ],
      ),
    );
  }
}


