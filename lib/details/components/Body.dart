import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';
import 'package:thesecurityman/details/Detail_Page/DetailScreen.dart';
import 'package:thesecurityman/details/components/CompanyCard.dart';
import 'package:thesecurityman/details/components/SearchBox.dart';

class Body extends StatelessWidget {

  final String identity;

  const Body({Key key, this.identity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
        child: Column(
          children: [
            SearchBox(changed: (value){
              bool status = false;
              int index;
              for(int i=0;i<companies.length;i++){
                if((companies[i].title).contains(value)){
                  status = true;
                  index = i;
                  break;
                }
              }
              if(status == true){
               /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                  "The Company exist in list : "+companies[index].title,
                        style: TextStyle(fontSize: 15),))); */
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog1(context,companies[index].title,index+1),);
              }
              else{
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The Company not exist in list : "+value)));
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog2(context,value),);
              }
            }),
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
                    position: companies[index].index,
                    companies: companies[index],
                    press: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(companies: companies[index],identity: identity,)));
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

  _buildPopupDialog1(BuildContext context, String title,int index) {

    return new AlertDialog(
      title: const Text('Results...'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("The Company is in list: "+title+"\n"+"At Position: $index"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
  _buildPopupDialog2(BuildContext context, String title) {

    return new AlertDialog(
      title: const Text('Results...'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("The Company is in list: "+title),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}




