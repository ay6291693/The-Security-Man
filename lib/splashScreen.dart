import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/dashboard.dart';
import 'package:thesecurityman/onboarding.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String finalEmail,identity;

  @override
  void initState() {
    //set time to load new page
    getValidation().whenComplete(() async{
      Future.delayed(Duration(seconds: 3), (){
        finalEmail == null?
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Onboarding())) :
        Navigator.pushReplacement(
            context,MaterialPageRoute(builder: (context)=>Dashboard(identity: identity,username: finalEmail,)
        )) ;
      });
    });
    super.initState();
  }

  Future getValidation() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('Email');
    var obtainedIdentity = sharedPreferences.getString('Identity');

    print(obtainedIdentity);
    print(obtainedEmail);
    setState(() {
      finalEmail = obtainedEmail;
      identity = obtainedIdentity;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Safearea is
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 350,
                    width: 350,
                    child: Lottie.asset("assets/tsm.json")),
                SizedBox(height: 20),
                Text("The Security Man",
                    style: TextStyle(
                        fontSize: 40,
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Hina')),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Proudly Made in India!",style: TextStyle(fontSize: 20, fontFamily: 'Hina'),),
                    SizedBox(width: 20,),
                    Container(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/Indian-Flag.png"),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "All rights are reserved, since @ 2021",
                  style: TextStyle(fontSize: 16, fontFamily: 'Hina'),
                )
              ])),
    ));
  }
}
