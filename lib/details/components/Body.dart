import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';
import 'package:thesecurityman/details/Detail_Page/DetailScreen.dart';
import 'package:thesecurityman/details/components/CompanyCard.dart';
import 'package:thesecurityman/details/components/SearchBox.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
        child: Column(
          children: [
            SearchBox(changed: (value){}),
            SizedBox(height: padding/4),
            Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70) ,
                  //Our Background
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                      )
                  ),
                ),
                ListView.builder(
                  itemCount: companies.length,
                  itemBuilder: (context,index) => CompanyCard(
                    itemIndex: index,
                    companies: companies[index],
                    press: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(companies: companies[index])));
                    },
                  ),
                )
              ],
            )
        )
      ],
    )
    );
  }
}




