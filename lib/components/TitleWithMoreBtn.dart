import 'package:flutter/material.dart';
import 'package:thesecurityman/components/TitleWithCustomUnderline.dart';
import 'package:thesecurityman/constants.dart';

class TitleWithMoreBtn extends StatelessWidget {

  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press
  }) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child:  Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title,),
          Spacer(),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              color: dashColor,
              onPressed: press,
              child: Text(
                  "More",
                  style: TextStyle(color:Colors.white)
              )
          )
        ],
      ) ,);
  }
}