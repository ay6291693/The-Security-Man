import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';

class CompanyCard extends StatefulWidget {
  const CompanyCard({
    Key key, this.itemIndex, this.position,this.companies, this.press,
  }) : super(key: key);

  final int itemIndex;
  final int position;
  final Companies companies;
  final Function press;

  @override
  _CompanyCardState createState() => _CompanyCardState(itemIndex,position,companies,press);
}

class _CompanyCardState extends State<CompanyCard> {
  final int itemIndex;
  final int position;
  final Companies companies;
  final Function press;

  _CompanyCardState(this.itemIndex, this.position, this.companies, this.press);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    Color _color = Colors.grey;
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2
        ),
        //color: Colors.blueAccent,
        height: 160,
        child: InkWell(
          onTap: press,
          child: Stack(
            //It is our Company Card Background
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                  height: 136,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: itemIndex % 2 == 0 ? kBlueColor : kSecondaryColor,
                      boxShadow: [kDefaultShadow]
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      //Our Company Image
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Hero(tag: '${companies.id}', child: Container(
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            height: 140,
                            width: 190,
                            child: Stack(
                              children: [
                                Container(
                                  child: Image.asset(
                                    companies.image, fit: BoxFit.cover,),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(Icons.favorite_rounded,color: mainColor),
                                )
                              ],
                            )
                        )),
                      ),
                    ],
                  )
              ),
              //Company title and location
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 133,
                  width: size.width - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        child: Text("$position) " + companies.title,
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      Spacer(),
                      Container(
                        // width: 170,  //changed
                        margin: EdgeInsets.only(right: 10,),
                        padding: EdgeInsets.symmetric(
                            horizontal: padding * 2,
                            vertical: padding / 4
                        ),
                        decoration: BoxDecoration(
                            color: itemIndex % 2 == 0
                                ? kBlueColor
                                : kSecondaryColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(22),
                                bottomLeft: Radius.circular(22)
                            )
                        ),
                        child: Text(
                          companies.location,
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 7
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
