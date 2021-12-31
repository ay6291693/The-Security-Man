import 'package:flutter/material.dart';
import 'package:thesecurityman/components/FeatureCompanyCard.dart';


class Features extends StatelessWidget {
  const Features({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          FeatureCompanyCard(image: "assets/Featu_image_1.png",press: (){},),
          FeatureCompanyCard(image: "assets/Featu_image_2.png",press: (){},),
          FeatureCompanyCard(image: "assets/Featu_image_3.png",press: (){},),
        ],
      ),
    );
  }
}
