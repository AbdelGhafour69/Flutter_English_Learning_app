import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/UserProvider.dart';
import 'package:quiz/USER/Welcomepage.dart';

class Register extends StatelessWidget {
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
            constraints: BoxConstraints.expand(height: 0.49019*height),
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
              padding: EdgeInsets.all(0.0245*height),
              height: 0.6127*height,
              margin: EdgeInsets.only(left: 0.0694*width, right: 0.0694*width),
              child: MyRegisterForm(),
            ),
          )
        ],
      ),
    );
  }
}

class MyRegisterForm extends StatefulWidget {
  @override
  _MyReState createState() => _MyReState();
}

class _MyReState extends State<MyRegisterForm> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String email, password;
  bool validated = true;
  String message;
  bool loading = false;
  String nom, prenom;
  var height;
  Widget getchild() {
    // if(loading)
    //   return LinearProgressIndicator();
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
    var width = MediaQuery.of(context).size.width;
    return loading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: pinkey,
            ),
          )
        : Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 0.0122*height,
                  ),
                  Text(
                    "Register",
                    style: titlebl(height),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 0.0244*height,
                    child: getchild(),
                  ),
                  TextFormField(
                    cursorColor: textcolor,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'First Name is required';
                      }
                    },
                    onSaved: (input) => prenom = input,
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
                      labelText: 'First Name',
                      labelStyle: simple(height),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.0244*height,
                  ),
                  TextFormField(
                    cursorColor: textcolor,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Last name is requierd';
                      }
                    },
                    onSaved: (input) => nom = input,
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
                      labelText: 'Last Name',
                      labelStyle: simple(height),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.0244*height,
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
                    height: 0.0244*height,
                  ),
                  TextFormField(
                    cursorColor: textcolor,
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Password is required';
                      }
                    },
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
                    height: 0.0244*height,
                  ),
                  ButtonTheme(
                    height: 0.06127*height,
                    child: FlatButton(
                      color: pinkey,
                      onPressed: () {
                        form.currentState.save();
                        if (form.currentState.validate()) {
                          signup();
                        }
                      },
                      child: Text(
                        "Register",
                        style: title(height),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  signup() async {
    setState(() {
      loading = true;
    });
    bool unique = false;
    await Firestore.instance
        .collection('User')
        .where('email', isEqualTo: email.trim())
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.length == 0) {
        unique = true;
      }
    });
    if (unique) {
      User user = User(email, password, nom, prenom);
      await Firestore.instance
          .collection('User')
          .add(user.toJson())
          .then((DocumentReference doc) async {
            user.id = doc.documentID;
        await Firestore.instance
            .collection('User')
            .document(doc.documentID)
            .collection('quizids')
            .document()
            .setData(user.toJson());
      });
      setState(() {
        loading = false;
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new ChangeNotifierProvider<UserProvider>(
              create: (BuildContext context) {
                return UserProvider(user);
              },
              child: QuizPage(user),
            ),
          ),
        );
      });
    } else {
      setState(() {
        loading = false;
        validated = false;
        message = 'email already in use';
      });
    }
  }
}
