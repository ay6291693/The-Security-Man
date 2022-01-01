import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/components/Body.dart';

class CompanyDetailPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("Dashboard",style: TextStyle(
        fontSize: 30,
        fontFamily: 'Hina',
        fontWeight: FontWeight.bold
      ),),
      centerTitle: false,
      actions: [
        IconButton(icon: Icon(Icons.favorite_border), onPressed: (){})
      ],
    );
  }
}
