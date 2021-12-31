import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/Register.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/homepage.dart';
import 'package:thesecurityman/main.dart';

class RegisterDashboard extends StatefulWidget {
  @override
  _RegisterDashboardState createState() => _RegisterDashboardState();
}

class _RegisterDashboardState extends State<RegisterDashboard> {
  @override
  Widget build(BuildContext context) {
    var images = ["assets/Customer.jpg","assets/Splash.jpg","assets/business-partner.jpg"];

    return Scaffold(
     /* appBar: AppBar(
        title: Text("The Security Man"),
        backgroundColor: Colors.deepOrange,
        //automaticallyImplyLeading: false,
      ), */
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
                "Register As",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Hina',
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
                      context, MaterialPageRoute(builder: (context) => Register(value: images[0])));
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
                      MaterialPageRoute(builder: (context) => Register(value: images[1])));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: mainColor,
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
                      MaterialPageRoute(builder: (context) => Register(value: images[2])));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                color: mainColor,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    "Already Have An Account!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,fontFamily: 'Hina',fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),)
              ),
            ],
          ),
        ),
      )
    );
  }
  }

