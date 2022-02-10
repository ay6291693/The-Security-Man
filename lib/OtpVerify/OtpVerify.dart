import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/OtpVerify/ConstantForOTP.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

class OtpVerify extends StatefulWidget {
  final String email,name;
  const OtpVerify({this.email,this.name});
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {

  final otp = TextEditingController();
  var res;
  bool verifiedOTP = false;

  Widget otpInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: otp,
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Enter OTP",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Otp is required';
            }
            return null;
          },
          onSaved: (String value){
            otp.text = value;
          },
        )
    );
  }

  void verifyEmailOTP(){
    var res = EmailAuth.validate(receiverMail: widget.email, userOTP: otp.text);

    if(res){
      verifiedOTP = true;
      Fluttertoast.showToast(msg: "OTP is Valid");
    }else{
      Fluttertoast.showToast(msg: "OTP is not Valid");
    }
  }
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Email Verification"),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "The Security Man",
                style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: mainColor,fontFamily: 'Hina'),),
              SizedBox(
                height: 100,
              ),
              otpInput(icon: Icons.message),
              SizedBox(
                height: 50,
              ),
              Container(
                child: InkWell(
                  onTap: (){
                    verifyEmailOTP();
                    if(verifiedOTP==true){

                      if(widget.name=="Register"){
                        Constant.check = true;
                      }else if(widget.name=="JobApplyForm"){
                        Constant.jobApplyEmailCheck=true;
                      }else if(widget.name=="SecurityServiceRequestForm"){
                        Constant.securityServiceRequestEmailCheck=true;
                      }

                      Future.delayed(Duration(seconds: 2),(){Navigator.of(context).pop();});
                    }
                    else{
                      Fluttertoast.showToast(msg: "Check the OTP");
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), color: mainColor),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
