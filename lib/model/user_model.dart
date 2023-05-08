class UserModel{
  String? uid;
  String? email;
  String? firstname;
  String? lastname;

  UserModel({this.uid,this.email,this.firstname,this.lastname});
  //recieve data from server
  factory UserModel.fromMap(map){
    return UserModel(
    uid:map['uid'],
    email:map['email'],
    firstname:map['firstname'],
    lastname:map['lastname']
    );
  }
  //send data to server
  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'firstname':firstname,
      'lastname':lastname,
    };
  }

}