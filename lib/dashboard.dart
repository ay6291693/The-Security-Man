import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesecurityman/components/dashbody.dart';
import 'package:thesecurityman/constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: DashBody(),
      // bottomNavigationBar: ,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFF0C9869),
      leading: IconButton(
        icon: SvgPicture.asset("assets/SplashScreen/icon_white.svg"),
        onPressed: () {},
      ),
    );
  }
}
