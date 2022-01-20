
class UserModel{
  String uid;
  String name;
  String phoneNum;
  String email;

  UserModel({this.uid,this.name,this.phoneNum,this.email});

  //Receiving Data from server
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      phoneNum: map['phoneNum'],
      email: map['email']
    );
  }
  //Sending Data to our server
  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'name' : name,
      'phoneNum' : phoneNum,
      'email' : email
    };
  }

}