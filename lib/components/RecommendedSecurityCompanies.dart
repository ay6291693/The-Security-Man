import 'package:flutter/material.dart';
import 'package:thesecurityman/components/RecommendedSecurityCard.dart';
import 'package:thesecurityman/details/components/CompanyDetailPage.dart';


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
            image: "assets/Secu_image_1.png",
            title: "Bombay Intelligence Security",
            location: "Alkapuri, Vadodara",
            press: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyDetailPage()));
            },
          ),
          RecommendedSecurityCard(
            image: "assets/Secu_image_2.png",
            title: "Detective Security Service",
            location: "Alkapuri, Vadodara",
            press: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyDetailPage()));
            },
          ),
          RecommendedSecurityCard(
            image: "assets/Secu_image_3.png",
            title: "CheckMate Security Services",
            location: "Fatehgunj, Vadodara",
            press: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyDetailPage()));
            },
          ),
          RecommendedSecurityCard(
            image: "assets/Secu_image_4.png",
            title: "Gujarat Security Services",
            location: "Alkapuri, Vadodara",
            press: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyDetailPage()));
            },
          )
        ],
      ),
    );
  }
}