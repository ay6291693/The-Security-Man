import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/Database_Models/security_service_request_data.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

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

  // Initial Selected Value
  String choose1,choose2,choose3;

  // List of items in our dropdown menu
  List items1 = ['0','1', '2', '3', '4', '5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
  //List items2 = ['0','1', '2', '3', '4', '5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
  //List items3 = ['0','1', '2', '3', '4', '5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];

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
                        Text(" Field denote they are mandatory ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,fontFamily: 'Hina',letterSpacing: 1.5),),
                      ],
                    )
                ),

                GestureDetector(
                  onTap: (){
                    var form = formKey.currentState;

                    int status1=0,status2=1;
                    if (form.validate()) {
                      status1=1;
                      form.save();
                    }
                    if(choose1==null||choose2==null||choose3==null){
                      status2=0;
                      Fluttertoast.showToast(msg: "Select the Respected Requirement of Security Person");
                    }
                    if(status1==1 && status2==1){

                      Fluttertoast.showToast(msg: "Sending the Request ...");
                      sendingDataToFireStore();

                      Future.delayed(Duration(seconds: 3),(){
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Your Data are Stored. You will be contacted by the TSM team shortly...");
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
}
