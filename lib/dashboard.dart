import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesecurityman/components/DashBottomNavBar.dart';
import 'package:thesecurityman/components/dashbody.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/login.dart';
import 'NavigationDrawer/NavigationDrawer.dart';



class Dashboard extends StatefulWidget {
  final String identity,username;

  const Dashboard({Key key, this.identity,this.username}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState(identity,username);
}

class _DashboardState extends State<Dashboard> {
  final String identity,username;
  _DashboardState(this.identity,this.username);

  var images = ["assets/Customer.jpg","assets/Splash.jpg","assets/business-partner.jpg"];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawerWidget(identity,username),
      appBar: buildAppBar(),
      body: DashBody(identity: identity,username: username),
      bottomNavigationBar: DashBottomNavBar(identity: identity,username: username),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: mainColor, // Color(0xFF0C9869),
      leading: IconButton(
        icon: SvgPicture.asset("assets/SplashScreen/icon_white.svg"),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: [
        IconButton(icon: Icon(Icons.logout), onPressed: (){logout(context);}),
        SizedBox(width: 18,)
      ],
    );
  }

  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    int index;

    switch(identity){
      case 'Customer':
        index=0;
        break;
      case 'Security Man':
        index=1;
        break;
      case 'Business Partner':
        index=2;
        break;
    }

    Fluttertoast.showToast(msg: "Log out! Successfully");

    //Removing value from sharedPreferences
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('Email');
    sharedPreferences.remove('Identity');

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login(value: images[index],identity: identity,)));
  }
}





