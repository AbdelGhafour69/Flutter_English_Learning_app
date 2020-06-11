import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:quiz/Colors.dart';
import 'package:flutter/material.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/Welcomepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0.09259*width, right: 0.09259*width, top: 0.0245*height),
            constraints: BoxConstraints.expand(height: 0.49*height),
            decoration: BoxDecoration(
              color: textcolor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              height: 0.6*height,
              margin: EdgeInsets.only(left: 0.0694*width, right: 0.0694*width),
              child: MyForm(),
            ),
          )
        ],
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String email, password;
  bool validated = true;
  String message;
  bool loading = false;
  var height;
    var width;
  Widget getchild() {
    if (loading) return LinearProgressIndicator();
    if (!validated) {
      return Text(
        message,
        style: notvalid(height),
        textAlign: TextAlign.center,
      );
    } else
      return Text("");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return loading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: pinkey,
            ),
          )
        : Form(
            //autovalidate: ,
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 0.01225*height,
                ),
                Text(
                  "Login",
                  style: titlebl(height),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 0.0245*height,
                  child: getchild(),
                ),
                TextFormField(
                  cursorColor: textcolor,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'e-mail is requierd';
                    }
                    if (!EmailValidator.validate(input)) {
                      return 'Please enter a valid email address';
                    }
                  },
                  onSaved: (input) => email = input,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: textcolor,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: Icon(Icons.mail),
                    ),
                    labelText: 'email',
                    labelStyle: simple(height),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.0245*height,
                ),
                TextFormField(
                  cursorColor: textcolor,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Password is required';
                    }
                  },
                  obscureText: true,
                  onSaved: (input) => password = input,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: textcolor,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      child: Icon(Icons.vpn_key),
                    ),
                    labelText: 'Password',
                    labelStyle: simple(height),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.0245*height,
                ),
                ButtonTheme(
                  height: 0.06127*height,
                  child: FlatButton(
                    color: pinkey,
                    onPressed: () {
                      form.currentState.save();
                      if (form.currentState.validate()) {
                        signin();
                      }
                    },
                    child: Text(
                      "Login",
                      style: title(height),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  signin() async {
    setState(() {
      loading = true;
    });
    await Firestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.length == 0) {
        setState(() {
          loading = false;
          validated = false;
          message = "No user with the input email";
        });
      } else {
        if (docs.documents[0].data['password'] != password) {
          setState(() {
            loading = false;
            validated = false;
            message = "Password is incorrect";
          });
        } else {
          User user = User.fromJson(docs.documents[0].data);
          user.id = docs.documents[0].documentID;

          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => QuizPage(user),
            ),
          );
        }
      }
    });
  }
}
