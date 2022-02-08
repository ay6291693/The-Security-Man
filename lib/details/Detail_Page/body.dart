import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/Companies.dart';
import 'package:thesecurityman/details/Detail_Page/JobApplyForm.dart';
import 'package:thesecurityman/details/Detail_Page/SecurityServiceRequest.dart';

class Body extends StatefulWidget {
  final Companies companies;
  final String identity;
  const Body({Key key, this.companies, this.identity}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _flutterTts = FlutterTts();
  bool isSpeaking = false;

  void initializeTts(){
    _flutterTts.setStartHandler((){
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler((){
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void speak() async{
    Fluttertoast.showToast(msg: "Audio is playing");
     await _flutterTts.speak(widget.companies.description);
  }
  void stop() async{
    Fluttertoast.showToast(msg: "Audio is stopped");
    await _flutterTts.stop();
    setState(() {
      isSpeaking=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _flutterTts.stop();
    super.dispose();
  }

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
                    tag: '${widget.companies.id}' ,
                    child: Container(
                      height: 175,
                      width: 175,
                      child: Image.asset(widget.companies.image, fit: BoxFit.fill,),
                    ),),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.companies.title,
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
                    widget.companies.location,
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
        Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: (){
              isSpeaking? stop():speak();
            },
            iconSize: 30,
            icon: Icon(isSpeaking?Icons.mic_none_outlined:Icons.mic_off_outlined,color: Colors.white,),
          ),
        ),
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: padding,right: padding),
                  child: Text(
                    widget.companies.description,
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

        if(widget.identity == 'Customer') InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SecurityServiceRequest(widget.companies.title)));
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
        else if (widget.identity == 'Security Man') InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>JobApplyForm(widget.companies.title)));
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
