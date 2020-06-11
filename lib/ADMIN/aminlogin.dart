import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ADMIN/AdminPage.dart';
import 'package:quiz/Colors.dart';

class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20),
            constraints: BoxConstraints.expand(height: 400),
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
              height: 500,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: LoginAdmin(),
            ),
          )
        ],
      ),
    );
  }
}

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String username, password;
  bool validated = true;
  String message;
  bool loading = false;
  var height,width;
  Widget getchild() {
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
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Admin Login",
                  style: titlebl(height),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                  child: getchild(),
                ),
                TextFormField(
                  cursorColor: textcolor,
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'username is requierd';
                    }
                  },
                  onSaved: (input) => username = input,
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
                    labelText: 'username',
                    labelStyle: simple(height),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                ButtonTheme(
                  height: 50,
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
        .collection('Admin')
        .where('username', isEqualTo: username)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.length == 0) {
        setState(() {
          loading = false;
          validated = false;
          message = 'No Admin with this username';
        });
      } else if (docs.documents[0].data['password'] != password) {
        setState(() {
          loading = false;
          validated = false;
          message = 'Password is incorrect';
        });
      } else
        setState(() {
          // validated = false;
          loading = false;
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new AdminPage(),
            ),
          );
        });
    });
  }
}