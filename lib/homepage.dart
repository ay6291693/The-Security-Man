import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/login.dart';
import 'package:thesecurityman/registerDashboard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    var images = ["assets/Customer.jpg","assets/Splash.jpg","assets/business-partner.jpg"];
   
    return Scaffold(
     /* appBar: AppBar(
        title: Text("The Security Man"),
        backgroundColor: Color(0xFF23408e), //Color(0xFF23408e)
        toolbarHeight: 70,
        //automaticallyImplyLeading: false,
      ), */
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "The Security Man",
                style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: mainColor,fontFamily: 'Hina'),),
              SizedBox(
                height: 40,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 3,
                    fontFamily: 'Hina',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login(value: images[0],identity: 'Customer',)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: mainColor,
                child: Text(
                  "Customer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hina'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 110),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(value: images[1],identity: 'Security Man',)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: mainColor,// Color(0xFF195ba5),
                child: Text(
                  "Security Man",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hina'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(value: images[2],identity: 'Business Partner',)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: mainColor,//Color(0xFF23408e),
                child: Text(
                  "Business Partner",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hina'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterDashboard()));
                  },
                  child: Text(
                    "Don't have Account? Click here !",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,fontFamily: 'Hina',fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),)
              ),
            ],
          ),
        ),
      )
    );
  }
}
