import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/registerDashboard.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {

  final String value;
  final String identity;
  Login({Key key, this.value, this.identity}) : super(key: key);

  @override
  LoginState createState() => LoginState(identity);
}

class LoginState extends State<Login> {

  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  // firebase authentication
  final _auth = FirebaseAuth.instance;

  final _formKey = new GlobalKey<FormState>();
  final String identity;
  LoginState(this.identity);

  //to enable eye button on password
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget emailInput({IconData icon}){
  return InputContainer(
      child: TextFormField(
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
               return 'Username/Email is not Valid';
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
        //keyboardType: TextInputType.visiblePassword,
           cursorColor: Colors.black,
           obscureText: _obscureText,
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

  Widget loginButton(Size size, BuildContext context){
  return InkWell(
        onTap: (){
          if(!_formKey.currentState.validate()){
            return;
          }
          _formKey.currentState.save();
          signIn(email.text, password.text);
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: mainColor),
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
}
  Widget registerButton(Size size, BuildContext context){
  return InkWell(
        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> RegisterDashboard()));
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: mainColor),
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
}

  void signIn(String email,String password) async{
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
      Navigator.pushAndRemoveUntil(context,
       MaterialPageRoute(builder: (context)=> Dashboard(identity: identity,username: email,)),
          (route)=> false),
      Fluttertoast.showToast(msg: "Login Successful"),

    },).catchError((e){
          Fluttertoast.showToast(msg: e.toString());
        }
    );
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
                      height: 100,
                    ),
                    Text(
                      "The Security Man",
                      style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: mainColor,fontFamily: 'Hina'),),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Logging As ...',
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Hina',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      //change of image require
                      '${widget.value}',
                      width: 150,
                      height: 150,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          emailInput(
                            icon: Icons.mail,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              passWordInput(
                                  icon: Icons.lock
                              ),
                              FlatButton(
                                  onPressed: _toggle,
                                  child: new Icon(_obscureText?Icons.visibility:Icons.visibility_off,size: 20,))
                            ],
                          ),
                          Container(
                           height: 35,
                           child: TextButton(
                                   onPressed: (){},
                                   child: Text('Forgot Password?',style: TextStyle(fontSize: 12),)
                               ),
                           ),
                          SizedBox(
                            height: 5,
                          ),
                          loginButton(size,context),
                          SizedBox(
                            height: 15,
                          ),
                          registerButton(size, context)
                        ],
                      ),
                    ),
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
