import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/onboarding.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load new page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onboarding()));
    });
    super.initState();
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
                Text(
                  "All Rights Are Reserved, Since @ 2021",
                  style: TextStyle(fontSize: 20, fontFamily: 'Hina'),
                )
              ])),
    ));
  }
}
