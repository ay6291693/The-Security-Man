import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/Database_Models/security_service_request_data.dart';
import 'package:thesecurityman/OtpVerify/ConstantForOTP.dart';
import 'package:thesecurityman/OtpVerify/OtpVerify.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';
import 'package:http/http.dart' as http;

class SecurityServiceRequest extends StatefulWidget {
  final String company;
  const SecurityServiceRequest(this.company);
  @override
  _SecurityServiceRequestState createState() => _SecurityServiceRequestState(company);
}

class _SecurityServiceRequestState extends State<SecurityServiceRequest> {

  final String company;
   _SecurityServiceRequestState(this.company);

  final _auth = FirebaseAuth.instance;

  final formKey = new GlobalKey<FormState>();

  final name = new TextEditingController();
  final phoneNum = new TextEditingController();
  final email = new TextEditingController();

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

  // Initial Selected Value
  String choose1,choose2,choose3;
  bool isPhoneNumberVerified=false;

  // List of items in our dropdown menu
  List items1 = ['0','1', '2', '3', '4', '5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];

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

  void sendOTP() async{
    EmailAuth.sessionName = "TSM Security Service Request Form Session";
    var res = await EmailAuth.sendOtp(receiverMail: email.text);

    if(res==true){
      Fluttertoast.showToast(msg: "Otp sent to ${email.text}");
    }
    else{
      Fluttertoast.showToast(msg: "OTP has not send");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
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
                              height:130,
                              child: phoneInput(icon: Icons.phone),
                            ),
                            TextButton(
                                onPressed: (){
                                  if (phoneNum.text==""){
                                    Fluttertoast.showToast(msg: "Please enter Phone Number");
                                  }
                                  else if(phoneNum.text.length!=10){
                                    Fluttertoast.showToast(msg: "Enter a Valid Phone Number");
                                  }
                                  else {
                                    getDataFromApi();
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
                                    sendOTP();
                                    Future.delayed(Duration(seconds: 2),(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpVerify(email: email.text,name: "SecurityServiceRequestForm")));});
                                  }
                                },
                                child: Text("Verify Email")),
                          ],
                        ),
                        // Number of  Security Guard
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              children: [
                                Text("Number of Security-Guard? ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
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
                            hint: Text("Number of Security-Guard?"),
                            value: choose1,
                            isExpanded: true,
                            style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Hina'),
                            underline: DropdownButtonHideUnderline(child: Container()),
                            dropdownColor: Colors.white.withOpacity(0.80),
                            icon: Icon(Icons.arrow_drop_down,color: mainColor,),
                            onChanged: (newValue) {
                              setState(() {
                                choose1 = newValue;
                              });
                            },
                            items: items1.map((valueItem){
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        // Number of  Security Supervisor
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              children: [
                                Text("Number of Security-Supervisor? ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
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
                            hint: Text("No. of Security-Supervisor?"),
                            value: choose2,
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Hina'
                            ),
                            underline: DropdownButtonHideUnderline(child: Container()),
                            dropdownColor: Colors.white.withOpacity(0.80),
                            icon: Icon(Icons.arrow_drop_down,color: mainColor,),
                            onChanged: (newValue) {
                              setState(() {
                                choose2 = newValue;
                              });
                            },
                            items: items1.map((valueItem){
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        // Number of  Security Gunman
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              children: [
                                Text("No. of Security GunMan? ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
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
                            hint: Text("No. of Security GunMan?"),
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Hina'
                            ),
                            underline: DropdownButtonHideUnderline(child: Container()),
                            value: choose3,
                            dropdownColor: Colors.white.withOpacity(0.80),
                            icon: Icon(Icons.arrow_drop_down,color: mainColor,),
                            onChanged: (newValue) {
                              setState(() {
                                choose3 = newValue;
                              });
                            },
                            items: items1.map((valueItem){
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                            width: size.width*0.8,
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child:  Row(
                              children: [
                                Icon(Icons.star,color:mainColor,size: 10,),
                                Text("Field denote they are mandatory ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
                              ],
                            )
                        ),

                        GestureDetector(
                          onTap: (){
                            var form = formKey.currentState;

                            int status1=0,status2=1,status3=1,status4=1;

                            if(form.validate()) {
                              status1=1;
                              form.save();
                            }
                            if(choose1==null||choose2==null||choose3==null){
                              status2=0;
                              Fluttertoast.showToast(msg: "Select the Respected Requirement of Security Person");
                            }
                            if(!Constant.securityServiceRequestEmailCheck){
                              status3=0;
                              Fluttertoast.showToast(msg: "Please Verify Email First");
                            }
                            if(isPhoneNumberVerified==false){
                              status4=0;
                              Fluttertoast.showToast(msg: "Please Verify Phone Number First");
                            }
                            if(status1==1 && status2==1&&status3==1&&status4==1){

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context)=> circular(size, context)
                              );

                              Fluttertoast.showToast(msg: "Sending the Request ...");

                              sendingDataToFireStore();

                              Future.delayed(Duration(seconds: 3),(){
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Fluttertoast.showToast(msg: "You will be contacted by the TSM team shortly...");
                              });

                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(vertical: 18),
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30), color: mainColor),
                            alignment: Alignment.center,
                            child: Text(
                              'SEND REQUEST',
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

  void sendingDataToFireStore() async{

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;
    SecurityServiceRequestData securityServiceRequest = new SecurityServiceRequestData();

    //setting data
    securityServiceRequest.uid = user.uid;
    securityServiceRequest.name = name.text;
    securityServiceRequest.phoneNum = phoneNum.text;
    securityServiceRequest.email = email.text;
    securityServiceRequest.company = company;
    securityServiceRequest.noOfSecGuard = choose1;
    securityServiceRequest.noOfSecSuper = choose2;
    securityServiceRequest.noOfSecGunman = choose3;

    await firebaseFirestore
    .collection("SecurityServiceRequest")
    .doc(user.uid)
    .set(securityServiceRequest.toMap());

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
