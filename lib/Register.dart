
import 'package:flutter/material.dart';
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

  String name;
  String phoneNum;
  String email;
  String password;
  String conPassword;

  final _formkey = new GlobalKey<FormState>();

  //for input data from user
  Widget nameInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
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
            name = value;
          },
        )
    );
  }
  Widget phoneInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
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
            return null;
          },
          onSaved: (String value){
            phoneNum = value;
          },
        )
    );
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
              return 'Please enter valid Username/Email';
            }
            return null;
          },
          onSaved: (String value){
            email = value;
          },
        )
    );
  }
  Widget passWordInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: true,
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
            password = value;
          },
        )
    );
  }
  Widget cpassWordInput({IconData icon}){
    return InputContainer(
        child: TextFormField(
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.black,
          obscureText: true,
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
            conPassword = value;
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

        if(password != conPassword){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("Password is not matching"),
                  duration: Duration(seconds: 2),
                  backgroundColor: mainColor,
                  behavior: SnackBarBehavior.fixed
                  )
          );
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Saving Data... Redirecting to Login Page"),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF23408e),
              behavior: SnackBarBehavior.fixed
          ));

          //Write code here to sent in the database

          //print(name);print(phoneNum);print(email);print(password);print(conPassword);

          Future.delayed(Duration(seconds: 3),(){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>  HomePage()));
          });
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
          "Save Details & login",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
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
                            //RoundedInput(icon: Icons.person, hint: 'Name',),
                            nameInput(icon: Icons.person),
                            SizedBox(
                              height: 0,
                            ),
                            //RoundedInput(icon: Icons.phone, hint: 'Phone Number'),
                            phoneInput(icon: Icons.phone),
                            SizedBox(
                              height: 0,
                            ),
                            //RoundedInput(icon: Icons.email, hint: 'Email'),
                            emailInput(icon: Icons.email),
                            SizedBox(
                              height: 0,
                            ),
                            //RoundedPasswordInput(hint: 'Password'),
                            passWordInput(icon: Icons.lock),
                            SizedBox(
                              height: 0,
                            ),
                            //RoundedPasswordInput(hint: 'Confirm Password'),
                            cpassWordInput(icon: Icons.lock),
                            SizedBox(
                              height: 2,
                            ),
                            //RoundedButton(title: 'Save Details & login'),
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