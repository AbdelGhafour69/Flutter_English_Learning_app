import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/QUIZ/Question.dart';
import 'package:quiz/QUIZ/Quiz.dart';
import 'package:quiz/USER/Result.dart';
import 'package:quiz/USER/User.dart';

class Quizanswer extends StatefulWidget {
  String quizid;
  User user;
  Quizanswer(this.quizid, this.user);

  @override
  _QuizanswerState createState() => _QuizanswerState(quizid, user);
}

class _QuizanswerState extends State<Quizanswer> {
  Quiz myquiz;
  int score = 0;
  int currentquestion;
  bool loading;
  int selected = -1;
  bool win = false;
  bool loss = false;
  int correct;
  String quizid;
  User user;

  _QuizanswerState(this.quizid, this.user);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    currentquestion = 0;
    getquiz(widget.quizid);
  }

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 0.210*height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 0.0367*height),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  color: pinkey),
                              child: FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0.0327*height,left: 0.1694*width),
                              child: Text(
                                "Answer Quiz!",
                                style: simple(height),
                              ),
                            ),
                            Container(
                              //child: Icon(Icons.arrow_forward_ios),
                              margin: EdgeInsets.only(right: 0.069*width, top: 0.0367*height),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.0245*height,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: getchildren(currentquestion),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0.0694*width, right: 0.0694*width, top: 0.0245*height),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 0.03676*height),
                          child: Text(
                            myquiz.mesquestions[currentquestion].question,
                            style: titleblack(height),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (win == false && loss == false) {
                                selected = 1;
                              }
                            });
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 0.0462*width, right: 0.0462*width),
                                    child: Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 0.06127*height, color: getcolor(1)),
                                    )),
                                Container(
                                  width: 0.6712*width,
                                  child: Text(
                                    myquiz.mesquestions[currentquestion].choix1,
                                    style: gettextstyle(1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (win == false && loss == false) {
                                selected = 2;
                              }
                            });
                          },
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 0.0462*width, right: 0.0462*width),
                                    child: Text(
                                      "B",
                                      style: TextStyle(
                                          fontSize: 0.06127*height, color: getcolor(2)),
                                    )),
                                Container(
                                  width: 0.6712*width,
                                  child: Text(
                                    myquiz.mesquestions[currentquestion].choix2,
                                    style: gettextstyle(2),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (win == false && loss == false) {
                                selected = 3;
                              }
                            });
                          },
                          child: Card(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 0.0462*width, right: 0.0462*width),
                                  child: Text(
                                    "C",
                                    style: TextStyle(
                                        fontSize: 0.06127*height, color: getcolor(3)),
                                  ),
                                ),
                                Container(
                                  width: 0.6712*width,
                                  child: Text(
                                    myquiz.mesquestions[currentquestion].choix3,
                                    style: gettextstyle(3),
                                    maxLines: 100,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.1225*height,
                        ),
                        ButtonTheme(
                          height: 0.098*height,
                          child: FlatButton(
                            child: Text(
                              "Answer it",
                              style: title(height),
                            ),
                            onPressed: checkwin,
                            color: pinkey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Color getcolor(int choice) {
    if (win == false && loss == false) {
      if (selected == choice) {
        return move;
      } else
        return Colors.black;
    } else {
      if (choice == correct) {
        return Colors.green;
      } else {
        if (selected == choice) {
          return Colors.red;
        } else {
          return Colors.black;
        }
      }
    }
  }

  TextStyle gettextstyle(int choice) {
    var height = MediaQuery.of(context).size.height;
    if (win == false && loss == false) {
      if (selected == choice) {
        return selectedtitleblack(height);
      } else
        return titleblack(height);
    } else {
      if (choice == correct) {
        return winstyle(height);
      } else {
        if (selected == choice) {
          return lossstyle(height);
        } else {
          return titleblack(height);
        }
      }
    }
  }

  void checkwin() {
    if (selected == -1) {
    } else {
      if (myquiz.mesquestions[currentquestion].reponse ==
          myquiz.mesquestions[currentquestion].choix1) {
        correct = 1;
      } else if (myquiz.mesquestions[currentquestion].reponse ==
          myquiz.mesquestions[currentquestion].choix2) {
        correct = 2;
      } else {
        correct = 3;
      }
      if (correct == selected) {
        setState(() {
          win = true;
          score++;
          print(score);
        });
      } else
        setState(() {
          loss = true;
        });
    }
    starttimer();
  }

  starttimer() async {
    var duration = new Duration(seconds: 2);
    print("hi");
    return new Timer(duration, route);
  }

  route() {
    if (currentquestion == myquiz.mesquestions.length - 1) {
      addtoids();
      print("i went");
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ResultPage(score, user),
        ),
      );
    } else {
      setState(() {
        currentquestion++;
        win = false;
        loss = false;
        selected = -1;
        correct = -1;
      });
    }
  }

  addtoids() async {
    await Firestore.instance
        .collection('User')
        .document(user.id.trim())
        .collection('quizids')
        .add({'quizid': quizid, 'score': score});
  }

  getquiz(String quizid) async {
    await Firestore.instance
        .collection('Quiz')
        .document(quizid.trim())
        .get()
        .then((DocumentSnapshot doc) {
      setState(() {
        myquiz = Quiz.fromJson(doc.data);
        myquiz.quizid = doc.documentID;
      });
    });
    await Firestore.instance
        .collection('Quiz')
        .document(quizid.trim())
        .collection('Question')
        .getDocuments()
        .then((QuerySnapshot docs) {
      setState(() {
        for (var doc in docs.documents) {
          Question q = Question.fromJson(doc.data);
          myquiz.mesquestions.add(q);
          print(myquiz.mesquestions.length);
        }
      });
    });
    setState(() {
      loading = false;
    });
  }

  List<Widget> getchildren(int current) {
    List<Widget> avatars = List<Widget>();
    for (int i = 0; i < myquiz.mesquestions.length; i++) {
      avatars.add(CircleAvatar(
        child: Text(
          (i + 1).toString(),
          style: TextStyle(color: current == i ? Colors.white : textcolor),
        ),
        backgroundColor: current == i ? greeny : Colors.white,
      ));
    }
    return avatars;
  }
}
