import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/QUIZ/Quiz.dart';
import 'package:quiz/USER/User.dart';
import 'package:quiz/USER/answerquiz.dart';

class Profile extends StatefulWidget {
  User user;
  Profile(this.user);

  @override
  _ProfileState createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  User user;
  _ProfileState(this.user);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: boxIsScrolled,
              floating: false,
              pinned: false,
              backgroundColor: pinkey,
              expandedHeight: 0.2696 * height,
              leading: FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const FractionalOffset(3.9, 1.0),
                                end: const FractionalOffset(0.4, 1.9),
                                colors: [move, pinkey],
                                stops: [0.0, 1.6],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 0.0735 * height, left: 0.0462 * width),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Hi There " +
                                  user.prenom +
                                  "\nThese are your quizes and scores!",
                              style: titlesmall(height),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListQuizes(user),
      ),
    );
  }
}

class ListQuizes extends StatefulWidget {
  User user;
  ListQuizes(this.user);

  @override
  _ListQuizesState createState() => _ListQuizesState(user);
}

class _ListQuizesState extends State<ListQuizes> {
  User user;
  _ListQuizesState(this.user);
  bool loading;
  @override
  void initState() {
    super.initState();
    loading = true;
  }

  List<Widget> cardlist = List<Widget>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: Firestore.instance
          .collection('User')
          .document(user.id.trim())
          .collection('quizids')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: pinkey,
            ),
          );
        if (snapshot.data.documents.length == 0)
          return Center(
            child: Text(
              "You haven\'t answered any quizes",
              style: simple(height),
            ),
          );
        getquiz(snapshot);
        return ListView(
          children: loading
              ? [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]
              : cardlist,
        );
      },
    );
  }

  getquiz(AsyncSnapshot snapshot) async {
    var height= MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Widget> cards = List<Widget>();
    for (var doc in snapshot.data.documents) {
      await Firestore.instance
          .collection('Quiz')
          .document(doc.data['quizid'])
          .get()
          .then((DocumentSnapshot docs) {
        Quiz myquizs = Quiz.fromJson(docs.data);
        myquizs.quizid = docs.documentID;
        cards.add(
          Container(
            //height: 100,
            margin: EdgeInsets.only(bottom: 0.0245*height, left: 0.0462*width, right: 0.0462*width),
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.only(top: 0.01225*height, left: 0.0462*width),
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
                    margin: EdgeInsets.only(top: 0.01225*height, bottom: 0.01225*height),
                    child: Text(
                      "Score: " + doc.data['score'].toString() + "/10",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 0.0196*height,
                          color: doc.data['score'] == 10
                              ? Colors.green
                              : Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 0.0462*width, bottom: 0, top: 5),
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
                        style: TextStyle(color: Colors.white, fontSize: 0.02205*height),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    }
    setState(() {
      cardlist = cards;
      loading = false;
    });
  }
}
