class User{
  String id;
  String nom;
  String prenom;
  String email;
  String password;
  User(this.email,this.password,this.nom,this.prenom);
  User.fromJson(Map<String,dynamic> json)
    : nom=json['nom'],
    prenom=json['prenom'],
    email=json['email'],
    password=json['password']
    ;

  Map<String,dynamic> toJson()=>{
    'email' : email,
    'nom' : nom,
    'prenom' : prenom,
    'password' : password,
  };

}