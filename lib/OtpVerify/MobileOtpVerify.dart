import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/OtpVerify/ConstantForOTP.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

class MobileOtpVerify extends StatefulWidget {
  final int otp;
  final String name;
  const MobileOtpVerify({this.otp,this.name});
  @override
  _MobileOtpVerifyState createState() => _MobileOtpVerifyState();
}

class _MobileOtpVerifyState extends State<MobileOtpVerify> {

  final OTP = new TextEditingController();

  Widget otpInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: OTP,
          maxLength: 4,
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
              return 'OTP is required';
            }
            bool isNumeric(String s) {
              if(s == null) {
                return false;
              }
              return double.parse(s, (e) => null) != null;
            }

            if(!isNumeric(value)){
              return 'OTP cannot have character';
            }
            if(value.length!=4){
              return 'OTP Length is 4 Digits';
            }
            return null;
          },
          onSaved: (String value){
            OTP.text = value;
          },
        )
    );
  }

  bool resultChecker(int enteredOtp) {
    //To validate OTP
    if(enteredOtp == widget.otp){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Number Verification"),
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
              otpInput(icon: Icons.phone),
              SizedBox(
                height: 50,
              ),
              Container(
                child: InkWell(
                  onTap: (){
                    if(resultChecker(int.parse(OTP.text))){
                      Fluttertoast.showToast(msg: "OTP is Valid");
                      //MobileOTP Verify used three places (Register,JobApplyForm,SecurityServiceRequest)
                      if(widget.name=="Register"){
                        Constant.phoneOtpVerifyForRegister=true;
                      }else if(widget.name=="JobApplyForm"){
                        Constant.phoneOtpVerifyForJobApplyForm=true;
                      }else{
                        Constant.phoneOtpVerifyForSecurityServiceRequest=true;
                      }

                      Future.delayed(Duration(seconds: 2),(){Navigator.of(context).pop();});

                    }else{
                      Fluttertoast.showToast(msg: "OTP is not valid");
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
