import 'package:flutter/material.dart';
import 'package:thesecurityman/components/RecommendedSecurityCard.dart';

class RecommendedSecurityCompanies extends StatelessWidget {
  const RecommendedSecurityCompanies({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:  Row(
        children: <Widget>[
          RecommendedSecurityCard(
            image: "assets/image_1.png",
            title: "Bombay Intelligence Security",
            location: "Alkapuri, Vadodara",
            press: (){},
          ),
          RecommendedSecurityCard(
            image: "assets/image_2.png",
            title: "Detective Security Service",
            location: "Alkapuri, Vadodara",
            press: (){},
          ),
          RecommendedSecurityCard(
            image: "assets/image_3.png",
            title: "CheckMate Security Services",
            location: "Fatehgunj, Vadodara",
            press: (){},
          ),
          RecommendedSecurityCard(
            image: "assets/image_1.png",
            title: "Gujarat Security Services",
            location: "Alkapuri, Vadodara",
            press: (){},
          )
        ],
      ),
    );
  }
}