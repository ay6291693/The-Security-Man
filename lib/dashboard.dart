import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesecurityman/components/DashBottomNavBar.dart';
import 'package:thesecurityman/components/dashbody.dart';
import 'package:thesecurityman/constants.dart';
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
    );
  }

}





