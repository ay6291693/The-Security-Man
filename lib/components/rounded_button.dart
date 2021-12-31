import 'package:flutter/material.dart';
import 'package:thesecurityman/registerDashboard.dart';
import '../dashboard.dart';
import 'package:thesecurityman/homepage.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        if(title == 'Login'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
        }
        else if(title == 'Save Details & login'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterDashboard()));
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Color(0xFF23408e)),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
