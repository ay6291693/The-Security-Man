import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: padding),
                height: size.width*0.8,
                //color: Colors.black,
                child: Stack(
                  children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("assets/Secu_image_1.png",),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
