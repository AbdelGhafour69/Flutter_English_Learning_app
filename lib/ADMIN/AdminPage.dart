import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quiz/QUIZ/Question.dart';
import 'package:quiz/QUIZ/Quiz.dart';
import 'package:quiz/USER/Widgets.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Myappbar(),
      ),
      body: Center(
        child: AddQuiz(),
      ),
    );
  }
}

class AddQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      height: 0.147 * height,
      child: GestureDetector(
          onTap: addQUIZ,
          child: Card(
            elevation: 3,
            color: orangey,
            child: Center(
                child: Text(
              "ADD QUIZes",
              style: titlebl(height),
            )),
          )),
    );
  }

  addQUIZ() async {
    var file = await FilePicker.getFile();
    if (file != null) {
      var bytes = file.readAsBytesSync();
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      for (var table in decoder.tables.keys) {
        int number = decoder.tables[table].rows[0][0];
        print('the number of quizes: ' + number.toString());
        int prev = 1;
        for (int i = 1; i <= number; i++) {
          print(prev);
          int numberquestion = decoder.tables[table].rows[prev][0];
          String title = decoder.tables[table].rows[prev][1];
          String category = decoder.tables[table].rows[prev][2].toLowerCase();
          prev++;
          List<Question> qs = List<Question>();
          print(numberquestion.toString() +
              " title: " +
              title +
              " category= " +
              category);
          for (int j = 1; j <= numberquestion; j++) {
            String question = decoder.tables[table].rows[prev][0].toString();
            String choix1 = decoder.tables[table].rows[prev][1].toString();
            String choix2 = decoder.tables[table].rows[prev][2].toString();
            String choix3 = decoder.tables[table].rows[prev][3].toString();
            String reponse = decoder.tables[table].rows[prev][4].toString();
            Question questionobd = Question(question.trim(), choix1.trim(),
                choix2.trim(), choix3.trim(), reponse.trim());
            qs.add(questionobd);
            prev++;
          }
          print(numberquestion);
          //prev = numberquestion;
          print("prev is :" + prev.toString());
          Quiz quiz = Quiz(category, qs, Timestamp.now(), title);
          insertquiz(quiz);
        }
      }
    }
  }

  insertquiz(Quiz quiz) async {
    await Firestore.instance
        .collection('Quiz')
        .add(quiz.toJson())
        .then((DocumentReference doc) async {
      for (Question q in quiz.mesquestions) {
        await Firestore.instance
            .collection('Quiz')
            .document(doc.documentID)
            .collection('Question')
            .add(q.toJson());
      }
    });
  }
}
