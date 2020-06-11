import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/QUIZ/Question.dart';

class Quiz {
  String quizid;
  String category;
  Timestamp uploaded;
  List<Question> mesquestions = List<Question>();
  String titre;

  Quiz(this.category, this.mesquestions, this.uploaded,this.titre);

  Quiz.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        uploaded = json['upload'],
        titre = json['titre'];

  Map<String,dynamic> toJson()=>{
    'category' : category,
    'upload' : uploaded,
    'titre' : titre,
  };

}