class JobApplyFormData{
  String uid,name,phoneNum,email,address,company,appliedFor,docURL;

  JobApplyFormData({this.uid,this.name,this.phoneNum,this.email,this.address,this.company,this.appliedFor,this.docURL});

  //Sending Data to Server
  Map<String,dynamic> toMap(){
    return{
      'uid' : uid,
      'name' : name,
      'phoneNum' : phoneNum,
      'email' : email,
      'address' : address,
      'company' : company,
      'appliedFor' : appliedFor,
      'docURL' : docURL,
    };
  }

}