import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';
import 'package:thesecurityman/details/Detail_Page/JobApplyForm.dart';
import 'package:thesecurityman/details/Detail_Page/SecurityServiceRequest.dart';

class Body extends StatelessWidget {

  final Companies companies;
  final String identity;

  const Body({Key key, this.companies, this.identity}) : super(key: key);
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
                    Hero(
                        tag: '${companies.id}' ,
                        child: Container(
                          height: 175,
                          width: 175,
                          child: Image.asset(companies.image, fit: BoxFit.fill,),
                        ),),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                       child: SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Text(
                           companies.title,
                           style: Theme
                               .of(context)
                               .textTheme
                               .button
                               .copyWith(
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       )
                    ),
                    SizedBox(height: 0,),
                    Text(
                      companies.location,
                        style: Theme
                            .of(context)
                            .textTheme
                            .button
                            .copyWith(
                            fontSize: 13,
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
        ),
        SizedBox(
          height: 10,
        ),

        if(identity == 'Customer') InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SecurityServiceRequest(companies.title)));
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Text(
              "Want Security Service? Click here!",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        )
        else if (identity == 'Security Man') InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>JobApplyForm(companies.title)));
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Text(
              "Apply for job? Click here!",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),

        SizedBox(height: 15,)
      ],
    );
  }
}
