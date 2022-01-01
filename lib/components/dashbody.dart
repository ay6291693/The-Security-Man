import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thesecurityman/components/FeatureCompanyCard.dart';
import 'package:thesecurityman/components/Features.dart';
import 'package:thesecurityman/components/RecommendedSecurityCard.dart';
import 'package:thesecurityman/components/RecommendedSecurityCompanies.dart';
import 'package:thesecurityman/components/TitleWithCustomUnderline.dart';
import 'package:thesecurityman/components/TitleWithMoreBtn.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/components/headerWithSearchBox.dart';
import 'package:thesecurityman/details/details_page.dart';

class DashBody extends StatefulWidget {
  @override
  _DashBodyState createState() => _DashBodyState();
}

class _DashBodyState extends State<DashBody> {
  @override
  Widget build(BuildContext context) {
    //It will give the screen size
    Size size = MediaQuery.of(context).size;

    //It will make header scrollable in small devices
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(
              title: "Recommended",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPage()));
              }),
          //It will take 40% of the screen width
          RecommendedSecurityCompanies(),
          TitleWithMoreBtn(
            title: "Features",
            press: () {},
          ),
          Features(),
          SizedBox(
            height: 0,
          ),
        ],
      ),
    );
  }
}
