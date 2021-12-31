import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';

class RecommendedSecurityCard extends StatelessWidget {
  const RecommendedSecurityCard({
    Key key, this.image, this.title, this.location, this.press,
  }) : super(key: key);

  final String image,title, location;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
          left: padding,
          top: padding/2,
          bottom: padding*1.3
      ),
      // color: Colors.black87,
      width: size.width*0.4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Column(
              children: <Widget>[
                Image.asset(image),
                Container(
                  padding: EdgeInsets.all(padding/2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: dashColor.withOpacity(0.23)
                        )
                      ]
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: "$title\n",style: Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.values[4]
                                  )),
                                  TextSpan(text: "$location",
                                      style: TextStyle(
                                          color: mainColor.withOpacity(0.7),
                                          fontFamily: 'Hina',fontSize: 18)
                                  )
                                ]
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}