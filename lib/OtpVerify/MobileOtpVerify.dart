import 'package:flutter/material.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

class MobileOtpVerify extends StatefulWidget {
  @override
  _MobileOtpVerifyState createState() => _MobileOtpVerifyState();
}

class _MobileOtpVerifyState extends State<MobileOtpVerify> {

  final phoneNum = new TextEditingController();

  Widget phoneInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: phoneNum,
          maxLength: 10,
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
              phoneInput(icon: Icons.phone),
              SizedBox(
                height: 50,
              ),
              Container(
                child: InkWell(
                  onTap: (){

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
