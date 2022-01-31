class SecurityServiceRequestData{
  String uid,name,phoneNum,email,company,noOfSecGuard,noOfSecSuper,noOfSecGunman;

  SecurityServiceRequestData({this.uid,this.name,this.phoneNum,this.email,this.company,this.noOfSecGuard,this.noOfSecSuper,this.noOfSecGunman});

  //Sending Data to Server
Map<String,dynamic> toMap(){
  return{
    'uid' : uid,
    'name' : name,
    'phoneNum' : phoneNum,
    'email' : email,
    'company' : company,
    'noOfSecGuard' : noOfSecGuard,
    'noOfSecSuper' : noOfSecSuper,
    'noOfSecGunman' : noOfSecGunman,
  };
}

}