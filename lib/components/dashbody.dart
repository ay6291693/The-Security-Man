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
import 'package:thesecurityman/details/components/CompanyDetailPage.dart';


class DashBody extends StatefulWidget {
  final String identity,username;

  const DashBody({Key key, this.identity,this.username}) : super(key: key);
  @override
  _DashBodyState createState() => _DashBodyState(identity,username);
}

class _DashBodyState extends State<DashBody> {
  final String identity,username;

  _DashBodyState(this.identity,this.username);

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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyDetailPage(identity: identity,username: username)));
              }),
          //It will take 40% of the screen width
          RecommendedSecurityCompanies(identity: identity),
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
