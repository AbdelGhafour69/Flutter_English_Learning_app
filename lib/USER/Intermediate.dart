import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/QUIZ/Quiz.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/answerquiz.dart';
class IntermediateTab extends StatefulWidget {
  User user;
  IntermediateTab(this.user);

  @override
  _IntermediateTabState createState() => _IntermediateTabState();
}

class _IntermediateTabState extends State<IntermediateTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('Quiz')
          .where('category', isEqualTo: 'intermediate')
          .snapshots(),
      builder: (context,snapshot){
        if(snapshot.data == null) return Center(child: CircularProgressIndicator(),);
        if(snapshot.data.documents.length == 0 ) return Center(child: Text("No Intermediate quizes"),);
        return ListView(children: getcards(snapshot, widget.user),);
      },
    );
  }
  List<Widget> getcards(AsyncSnapshot snapshot,User user) {
    //print("im here");
    var height = MediaQuery.of(context).size.height;
    List<Widget> mycards = List<Widget>();
    for (int i = 0; i < snapshot.data.documents.length; i++) {
      Quiz myquizs = Quiz.fromJson(snapshot.data.documents[i].data);
      DateTime upload = myquizs.uploaded.toDate();
      String uploadtime = DateFormat.yMEd().format(upload);
      myquizs.quizid = snapshot.data.documents[i].documentID;
      mycards.add(Container(
        //height: 100,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 10, left: 20),
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
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  uploadtime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20, bottom: 0, top: 5),
                child: FlatButton(
                  onPressed: () => Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Quizanswer(myquizs.quizid,user),
                    ),
                  ),
                  color: move,
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return mycards;
  }
}