import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:thesecurityman/Database_Models/job_apply_form.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

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
              return 'Phone number cannot have character';
            }
            if(value.length!=10){
              return 'Please enter number(Max. 10 Digits)';
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
            labelText: "Username/Email",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Username/Email is required';
            }
            if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
              return 'Please enter valid Username/Email';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Text(
                      'The Security Man',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  nameInput(icon: Icons.person),
                  phoneInput(icon: Icons.phone),
                  emailInput(icon: Icons.email),
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
                      int status1=0,status2=1;

                      if (form.validate()) {
                        status1=1;
                        form.save();
                      }
                      if(choose==null){
                        status2=0;
                        Fluttertoast.showToast(msg: "Select position You are applying for .....");
                      }

                      if(status1==1 && status2==1){
                        Fluttertoast.showToast(msg: "Sending the Request ...");
                        sentDataToFireStore();
                        Future.delayed(Duration(seconds: 3),(){
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
    Future.delayed(Duration(seconds: 2),(){OpenFile.open(file.path);});
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

    //Sending data to Firebase Firestore
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
}
