import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:email_auth/email_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:sms/sms.dart';
import 'package:thesecurityman/Database_Models/job_apply_form.dart';
import 'package:thesecurityman/OtpVerify/ConstantForOTP.dart';
import 'package:thesecurityman/OtpVerify/MobileOtpVerify.dart';
import 'package:thesecurityman/OtpVerify/OtpVerify.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';
import 'package:http/http.dart' as http;

class JobApplyForm extends StatefulWidget {
  final String company;
  const JobApplyForm(this.company);

  @override
  _JobApplyFormState createState() => _JobApplyFormState(company);
}

class _JobApplyFormState extends State<JobApplyForm> {

  final String company;
  _JobApplyFormState(this.company);

  final formKey = new GlobalKey<FormState>();

  PlatformFile file;
  String filename= "";
  String downloadURL="";
  bool statusForDocumentUpload=false;

  User user = FirebaseAuth.instance.currentUser;

  final name = new TextEditingController();
  final phoneNum = new TextEditingController();
  final email = new TextEditingController();
  final address = new TextEditingController();

  bool isEmailVerified;
  bool isPhoneNumberVerified=false;

  int _otp;

  @override
  void initState() {
    super.initState();
  }

  Widget nameInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: name,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Name",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Name is required';
            }
            return null;
          },
          onSaved: (String value){
            name.text = value;
          },
        )
    );
  }
  Widget phoneInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: phoneNum,
          cursorColor: Colors.black,
          maxLength: 10,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Phone Number",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Phone number is required';
            }
            bool isNumeric(String s) {
              if(s == null) {
                return false;
              }
              return double.parse(s, (e) => null) != null;
            }

            if(!isNumeric(value)){
              return 'Enter only Number';
            }
            if(value.length!=10){
              return 'Please enter 10 Digits';
            }
            return null;
          },
          onSaved: (String value){
            phoneNum.text = value;
          },
        )
    );
  }
  Widget emailInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: email,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Email",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Email is required';
            }
            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
              return 'Please enter valid Email';
            }
            return null;
          },
          onSaved: (String value){
            email.text = value;
          },
        )
    );
  }
  Widget addressInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: address,
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Address",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
          onSaved: (String value){
            address.text = value;
          },
        )
    );
  }

  // Initial Selected Value
  String choose;

  // List of items in our dropdown menu
  List items = ['Security Guard','Security Supervisor','Security GunMan'];

  circular(Size size,BuildContext context){
    return new AlertDialog(
        title: Text("Loading..."),
        content:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: SpinKitFadingCircle(
                  duration: Duration(seconds: 2),
                  color: mainColor,
                ),
              ),
            ]
        )
    );
  }

  void sendEmailOTP() async{
    EmailAuth.sessionName = "TSM Job Apply Form Session";
    var res = await EmailAuth.sendOtp(receiverMail: email.text);

    if(res==true){
      Fluttertoast.showToast(msg: "Otp sent to ${email.text}");
    }
    else{
      Fluttertoast.showToast(msg: "OTP has not send");
    }
  }

  void sendOtp(String phoneNum){

    int _minOtpValue, _maxOtpValue;

    void generateOtp([int min = 1000, int max = 9999]) {
      //Generates four digit OTP by default
      _minOtpValue = min;
      _maxOtpValue = max;
      _otp = _minOtpValue + Random().nextInt(_maxOtpValue - _minOtpValue);
    }

    generateOtp();

    SmsSender sender = new SmsSender();

    String address = '+91' + phoneNum;

    sender.sendSms(new SmsMessage(address,"Your OTP for TSM Registration is: "+_otp.toString()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              child: Text(
                "The Security Man",
                style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: mainColor,fontFamily: 'Hina'),),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        nameInput(icon: Icons.person),
                        //For phone number
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height:120,
                              child: phoneInput(icon: Icons.phone),
                            ),
                            TextButton(
                                onPressed: (){
                                  if (phoneNum.text==""){
                                    Fluttertoast.showToast(msg: "Please enter Email");
                                  }
                                  else if(phoneNum.text.length!=10){
                                    Fluttertoast.showToast(msg: "Enter a Valid Email");
                                  }
                                  else {
                                   //getDataFromApi();
                                    sendOtp(phoneNum.text);
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>MobileOtpVerify(otp: _otp,name: "JobApplyForm",)));
                                  }
                                },
                                child: Text("Verify Phone Number")),
                          ],
                        ),
                        //For email
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height:120,
                              child: emailInput(icon: Icons.email),
                            ),
                            TextButton(
                                onPressed: (){
                                  if (email.text==""){
                                    Fluttertoast.showToast(msg: "Please enter Email");
                                  }
                                  else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.text)){
                                    Fluttertoast.showToast(msg: "Enter a Valid Email");
                                  }
                                  else {
                                    sendEmailOTP();
                                    Future.delayed(Duration(seconds: 2),(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpVerify(email: email.text,name: "JobApplyForm",)));});
                                  }
                                },
                                child: Text("Verify Email")),
                          ],
                        ),
                        addressInput(icon: Icons.location_on),
                        SizedBox(
                          height: 5,
                        ),
                        //Select position to apply for job
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text("You are Applying For? ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
                                Icon(Icons.star,color: mainColor,size: 12,)
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), color: Colors.black12),
                          child:  DropdownButton(
                            hint: Text("You Are Applying for?",style: TextStyle(color: Colors.black),),
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Hina'
                            ),
                            value: choose,
                            underline: DropdownButtonHideUnderline(child: Container()),
                            dropdownColor: Colors.white.withOpacity(0.80),
                            icon: Icon(Icons.arrow_drop_down,color: mainColor,),
                            onChanged: (newValue) {
                              setState(() {
                                choose = newValue;
                              });
                            },
                            items: items.map((valueItem){
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //Select documents to upload
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              children: [
                                Text("Upload Document for Verification ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
                                Icon(Icons.star,color: mainColor,size: 12,)
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), color: Colors.black12),
                          child: Row(
                            children: [
                              Text("Select Document  ==>",style: TextStyle(color: Colors.black,),),
                              SizedBox(width: 30,),
                              IconButton(
                                icon: Icon(Icons.upload_file,color: mainColor,size: 35,),
                                onPressed: () async{
                                  selectingSystemDocuments();
                                },
                              )
                            ],
                          ),
                        ),
                        Text(statusForDocumentUpload==true?"Document Uploaded Successfully":"(After Selecting Document wait for some time...)",style: TextStyle(fontSize: 14,fontFamily: 'Hina'),),
                        //info icon for uploading documents
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 2),
                          width: size.width,
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              Expanded(
                                child:  SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: file==null?Text("No File Selected"):Text(filename),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.info_outline,color: mainColor,),
                                onPressed: (){
                                  String title = "Upload any one Document from below list:\n\n 1. Adhar Card\n 2. Voter-Id Card\n 3. Driving Licence\n \n Allowed Files are \n.pdf ,.jpg, .jpeg, .png";
                                  showDialog(context: context,builder: (context)=>_buildPopupDialog(context,title));
                                },
                                iconSize: 24,
                              )
                            ],
                          ),
                        ),

                        //Apply for job button
                        GestureDetector(
                          onTap: (){
                            var form = formKey.currentState;
                            int status1=0,status2=1,status3=1,status4=1,status5=1;

                            if (form.validate()) {
                              status1=1;
                              form.save();
                            }
                            if(choose==null){
                              status2=0;
                              Fluttertoast.showToast(msg: "Select position You are applying for .....");
                            }
                            if(!statusForDocumentUpload){
                              status3=0;
                              Fluttertoast.showToast(msg: "Please Upload Document.");
                            }
                            if(!Constant.jobApplyEmailCheck){
                              status4=0;
                              Fluttertoast.showToast(msg: "Please Verify Email First");
                            }
                            if(Constant.phoneOtpVerifyForJobApplyForm==false){
                              status5=0;
                              Fluttertoast.showToast(msg: "Please Verify Phone Number First");
                            }
                            if(status1==1 && status2==1 && status3==1&& status4==1&& status5==1){

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context)=> circular(size, context)
                              );
                              Fluttertoast.showToast(msg: "Sending the Request ...");
                              sentDataToFireStore();

                              Future.delayed(Duration(seconds: 3),(){
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Fluttertoast.showToast(msg: "Your Data are Stored. Our team will contact you soon.");
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            padding: EdgeInsets.symmetric(vertical: 18),
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30), color: mainColor),
                            alignment: Alignment.center,
                            child: Text(
                              'APPLY FOR JOB',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  _buildPopupDialog(BuildContext context,String title) {

    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  void openFile(PlatformFile file) {
    Fluttertoast.showToast(msg: "File is Selected");
    Future.delayed(
        Duration(seconds: 2),
            (){OpenFile.open(file.path);});
    setState(() {
      filename = file.name;
    });
  }

  void selectingSystemDocuments() async{
    final result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf','jpeg','jpg','png'],type: FileType.custom);

    if(result==null) return;

    file = result.files.first;

    openFile(file);
    uploadImage(file).whenComplete(() => {
      Fluttertoast.showToast(msg: "Document Uploaded Successfully"),
    });
    setState(() {
      statusForDocumentUpload=true;
    });
  }

  //Storing Documents to Firebase Storage
  Future uploadImage(PlatformFile file) async{
    final postID = DateTime.now().microsecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("${user.uid}/images").child("post_$postID");

    //converting PlatformFile to File
    final File finalFile = File(file.path);
    await ref.putFile(finalFile);
    downloadURL = await ref.getDownloadURL();
  }

  Future<void> sentDataToFireStore() async{

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    JobApplyFormData jobApplyFormData = new JobApplyFormData();

    jobApplyFormData.uid = user.uid;
    jobApplyFormData.name = name.text;
    jobApplyFormData.phoneNum = phoneNum.text;
    jobApplyFormData.email = email.text;
    jobApplyFormData.address = address.text;
    jobApplyFormData.company = company;
    jobApplyFormData.appliedFor = choose;
    jobApplyFormData.docURL = downloadURL;

    await firebaseFirestore
        .collection("AppliedForJob")
        .doc(user.uid)
        .set(jobApplyFormData.toMap());

  }

  void getDataFromApi() async{
    var response = await http.get(
        Uri.http("apilayer.net", "/api/validate",
            {"access_key":"c8dc85eefd805c9a85a140b594f2cd88","number":"${phoneNum.text}","country_code":"IN","format":"format"}
        ));

    var jsonData = jsonDecode(response.body);
    print(jsonData);

    if(jsonData["valid"]==true){
      setState(() {
        isPhoneNumberVerified=true;
      });
      Fluttertoast.showToast(msg: "Phone number verified");
    }
    else{
      Fluttertoast.showToast(msg: "Phone number not verified\n\n \t Enter Correct Number");
    }

  }
}
