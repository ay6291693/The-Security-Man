import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thesecurityman/components/input_container.dart';
import 'package:thesecurityman/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(padding),
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding/4
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withOpacity(0.4),
            boxShadow: [kDefaultShadow]
          ),
          child: TextField(
            style: TextStyle(
              color: Colors.white
            ),
            decoration: InputDecoration(
              icon: Icon(Icons.search,size: 30,),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                color: Colors.white
              )
            ),
          ),
        )
      ],
    );
  }
}
