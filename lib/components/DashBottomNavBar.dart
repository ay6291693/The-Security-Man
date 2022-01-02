import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/dashboard.dart';

class DashBottomNavBar extends StatelessWidget {
  const DashBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: padding*2,
          right: padding*2,
          bottom: padding
      ),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -12),
            blurRadius: 25,
            color: dashColor.withOpacity(0.40),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: mainColor,
            splashColor: dashColor.withOpacity(0.45),
            splashRadius: 30,
            onPressed: () {},
            iconSize: 28,
          ),
          IconButton(
            icon: Icon(Icons.home_outlined),
            color: mainColor,
            splashColor: dashColor.withOpacity(0.45),
            splashRadius: 30,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
            },
            iconSize: 28,
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: mainColor,
            splashColor: dashColor.withOpacity(0.45),
            onPressed: () {},
            splashRadius: 30,
            iconSize: 28,
          ),
        ],
      ),
    );
  }
}