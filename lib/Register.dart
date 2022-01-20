
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/Database_Models/user_model.dart';
import 'package:thesecurityman/constants.dart';
import 'components/input_container.dart';
import 'homepage.dart';

class Register extends StatefulWidget{

  Register({Key key,this.value}) : super(key: key);

  final String value;

  @override
  RegisterState createState()=> RegisterState();
}
class RegisterState extends State<Register>{

  final TextEditingController name = new TextEditingController();
  final TextEditingController phoneNum = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController conPassword = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _formkey = new GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  //for input data from user
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
  Widget passWordInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: password,
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: _obscureText1,
          decoration: InputDecoration(
            labelText: "Password",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Password is required';
            }
            if(!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!#%*?&]{6,15}$").hasMatch(value)){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter password should be 1) One Capital Letter 2) Special Character 3) One Number 4) Length Should be 6-15:"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Color(0xFF23408e),
                    behavior: SnackBarBehavior.fixed
                ));
              return 'Password is too weak';
            }
            return null;
          },
          onSaved: (String value){
            password.text = value;
          },
        )
    );
  }
  Widget cPassWordInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          controller: conPassword,
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: _obscureText2,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            icon: Icon(icon,color: mainColor,),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 1,top: 5,right: 15,bottom: 5),
          ),
          validator: (String value){
            if(value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
          onSaved: (String value){
            conPassword.text = value;
          },
        )
    );
  }

  //save details button
  Widget saveRegisterDetailsButton(Size size, BuildContext context){
    return InkWell(
      onTap: (){
        if(!_formkey.currentState.validate()){
          return;
        }
        _formkey.currentState.save();
        signUp(email.text, password.text);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: mainColor),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          "Save Details & login",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
  
  void signUp(String email,String password) async{
    if(password != conPassword.text){
      Fluttertoast.showToast(msg: "Password is not Matching");
    }
    else{
      Fluttertoast.showToast(msg: "Saving Data... Redirecting to Login Page");
      //Write code here to sent in the database
      await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) =>{
        postDetailsToFireStore()
      }
      ).catchError((e)=>{
        Fluttertoast.showToast(msg: e),
      });
    }
  }

  postDetailsToFireStore() async {
    // Call the FireStore
    //Call the UserModel
    // sending data
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.uid = user.uid;
    userModel.name = name.text;
    userModel.email = user.email;
    userModel.phoneNum = phoneNum.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created Successfully");

    Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context)=> HomePage()), 
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoggingSize = size.height - (size.height * 0.1);

    return Scaffold(
      body: Stack(
        children: [
          //login form
          Align(
            alignment: Alignment.center,
            child: Container(
                width: size.width,
                height: defaultLoggingSize,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "The Security Man",
                        style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: mainColor,fontFamily: 'Hina'),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Register As",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Hina',
                          fontWeight: FontWeight.bold
                        ),

                      ),
                      SizedBox(height: 0),
                      Image.asset(
                        //change of image require
                        '${widget.value}',
                        width: 140,
                        height: 90,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            nameInput(icon: Icons.person),
                            SizedBox(
                              height: 0,
                            ),
                            phoneInput(icon: Icons.phone),
                            SizedBox(
                              height: 0,
                            ),
                            emailInput(icon: Icons.email),
                            SizedBox(
                              height: 0,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                passWordInput(icon: Icons.lock),
                                FlatButton(
                                    onPressed: _toggle1,
                                    child: new Icon(_obscureText1?Icons.visibility:Icons.visibility_off,size: 20,)),
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                cPassWordInput(icon: Icons.lock),
                                FlatButton(
                                    onPressed: _toggle2,
                                    child: new Icon(_obscureText2?Icons.visibility:Icons.visibility_off,size: 20,)),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            saveRegisterDetailsButton(size, context)
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

}