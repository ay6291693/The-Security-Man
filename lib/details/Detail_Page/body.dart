import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';

class Body extends StatelessWidget {

  final Companies companies;

  const Body({Key key, this.companies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)
            ),
          ),
          child: Container(
                margin: EdgeInsets.symmetric(vertical: padding),
                height: size.width*0.7,
                //color: Colors.black,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 175,
                      width: 175,
                      child: Image.asset(companies.image, fit: BoxFit.fill,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(child: SingleChildScrollView(
                      child: Text(
                        companies.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .button
                            .copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )),
                    Text(
                      companies.location,
                        style: Theme
                            .of(context)
                            .textTheme
                            .button
                            .copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ],
                ),
              )
        ),
        SizedBox(
         height: 20,
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: padding,right: padding),
              child: Text(
                companies.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),),
            )
          )
        )
      ],
    );
  }
}
