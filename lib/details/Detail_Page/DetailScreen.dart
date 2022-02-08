import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';
import 'package:thesecurityman/details/Detail_Page/body.dart';

class DetailsScreen extends StatelessWidget {

  final Companies companies;
  final String identity;

  const DetailsScreen({Key key, this.companies, this.identity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(companies: companies,identity: identity,),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        //padding: EdgeInsets.only(left: padding),
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: (){Navigator.pop(context);},
      ),
      backgroundColor: kBackgroundColor,
      elevation: 0,
      title: Text("Back".toUpperCase(),style: Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),),
      centerTitle: false,
      actions: [
        IconButton(icon: Icon(Icons.favorite_border,color: Colors.black,), onPressed: (){}),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
