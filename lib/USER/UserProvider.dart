
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/USER/User.dart';

class UserProvider with ChangeNotifier{
  User user;

  UserProvider(this.user);
  addQuizid(String quizid,int score)async{
    Map<String,dynamic> map={
    'quizid' : quizid,
    'score' : score
  };
    await Firestore.instance.collection('User').document(user.id).collection('quizids').add(map);
    notifyListeners();
  }
}