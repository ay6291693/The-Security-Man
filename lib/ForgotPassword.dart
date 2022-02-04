import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final email = new TextEditingController();
  final _auth = FirebaseAuth.instance;

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
              return 'Email is not Valid';
            }
            return null;
          },
          onSaved: (String value){
            email.text = value;
          },
        )
    );
  }
  Widget sendRequest(Size size, BuildContext context){
    return InkWell(
      onTap: (){
        _auth.sendPasswordResetEmail(email: email.text);
        Fluttertoast.showToast(msg: "Reset Password mail has sent...");
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: mainColor),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          "Send Request",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    double defaultLoggingSize = size.height - (size.height * 0.4);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
            width: size.width,
            height: defaultLoggingSize,
            child:  SingleChildScrollView(
              child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                emailInput(icon: Icons.mail),
                SizedBox(
                  height: 30,
                ),
                sendRequest(size, context)
              ],
            ),
          )
        )
      )
    );
  }
}
