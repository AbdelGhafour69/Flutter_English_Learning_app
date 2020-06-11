import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:intl/intl.dart';
import 'package:quiz/QUIZ/Quiz.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/Widgets.dart';
import 'package:quiz/USER/answerquiz.dart';

class QuizPage extends StatefulWidget {
  User user;
  QuizPage(this.user);

  @override
  _QuizPageState createState() => _QuizPageState(user);
}

class _QuizPageState extends State<QuizPage> {
  User user;
  _QuizPageState(this.user);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.1225*height),
        child: Myappbar(),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 0.0367 * height,
          ),
          CardList(user),
          SizedBox(
            height: 0.049 * height,
          ),
          OrangeCard(user),
          SizedBox(
            height: 0.0367 * height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 0.069 * width),
                child: Text(
                  "Recent Quizes",
                  style: simple(height),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: 0.069 * width),
                  child: Text(
                    "More",
                    style: simplepink(height),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 0.01225*height,
          ),
          QuizCards(user)
        ],
      ),
    );
  }
}

class Sawsan extends StatefulWidget {
  @override
  _SawsanState createState() => _SawsanState();
}

class _SawsanState extends State<Sawsan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class QuizCards extends StatefulWidget {
  User user;
  QuizCards(this.user);

  @override
  _QuizCardsState createState() => _QuizCardsState(user);
}

class _QuizCardsState extends State<QuizCards> {
  User user;
  _QuizCardsState(this.user);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream:
            Firestore.instance.collection('Quiz').orderBy('upload').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return CircularProgressIndicator();
          else {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text("No recents"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: getcards(snapshot, user.id, height, width),
            );
          }
        });
  }

  List<Widget> getcards(
      AsyncSnapshot snapshot, String userid, var height, var width) {
    //print("im here");
    int j = 1;
    List<Widget> mycards = List<Widget>();
    for (int i = 0; i < snapshot.data.documents.length; i++) {
      if (j == 10) {
        break;
      }
      Quiz myquizs = Quiz.fromJson(snapshot.data.documents[i].data);
      DateTime upload = myquizs.uploaded.toDate();
      String uploadtime = DateFormat.yMEd().format(upload);
      myquizs.quizid = snapshot.data.documents[i].documentID;
      mycards.add(Container(
        //height: 100,
        margin: EdgeInsets.only(
            bottom: 0.0245 * height,
            left: 0.04629 * width,
            right: 0.04629 * width),
        color: Colors.white,
        child: ListTile(
          contentPadding:
              EdgeInsets.only(top: 0.01225 * height, left: 0.04629 * width),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //width: 200,
                child: Text(
                  myquizs.category + " - " + myquizs.titre,
                  style: simple(height),
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: 0.01225 * height, bottom: 0.01225 * height),
                child: Text(
                  uploadtime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 0.0196 * height,
                      color: Colors.grey),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(right: 0.04629 * width, bottom: 0, top: 5),
                child: FlatButton(
                  onPressed: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new Quizanswer(myquizs.quizid, user),
                    ),
                  ),
                  color: move,
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(
                        color: Colors.white, fontSize: 0.02205 * height),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
      j++;
    }
    return mycards;
  }
}
