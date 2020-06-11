class Question{
  String questionid;
  String choix1;
  String choix2;
  String choix3;
  String question;
  String reponse;

  Question(this.question,this.choix1,this.choix2,this.choix3,this.reponse);

  Question.fromJson(Map<String , dynamic> json)
    :
    choix1 = json['choix1'],
    choix2 = json['choix2'],
    choix3 = json['choix3'],
    reponse = json['reponse'],
    question = json['question'];

   Map<String,dynamic> toJson()=>{
    'question' : question,
    'reponse' : reponse,
    'choix1' : choix1,
    'choix2' : choix2,
    'choix3' : choix3,
    
  };

}