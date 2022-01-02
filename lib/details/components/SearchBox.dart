import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key, this.changed,
  }) : super(key: key);

  final ValueChanged changed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onChanged: changed,
        style: TextStyle(
            color: Colors.white
        ),
        decoration: InputDecoration(
            icon: Icon(Icons.search,size: 26,color: Colors.white,),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(
                color: Colors.white
            )
        ),
      ),
    );
  }
}