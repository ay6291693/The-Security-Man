import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';

class FeatureCompanyCard extends StatelessWidget {
  const FeatureCompanyCard({
    Key key, this.image, this.press,
  }) : super(key: key);
  final String image;
  final Function press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: padding,top: padding/2,bottom: padding/2),
        width: size.width*0.8,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            )
        ),
      ),
    );
  }
}