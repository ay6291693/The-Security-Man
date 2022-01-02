import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {

  final Size size;
  const HeaderWithSearchBox({
    Key key,
    @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      //It will create a container of 20% height of the screen
      height: size.height*0.2,
      margin: EdgeInsets.only(
          bottom: padding*2.0
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: padding,
                right: padding-5,
                bottom: 20
            ),
            height: size.height*0.2 - 27,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 3,),
                Text("Be Assured, Be Secured",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Spacer(flex: 1,),
                Container(
                  child: Image.asset("assets/The.png"),
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: padding),
                padding: EdgeInsets.symmetric(horizontal: padding),
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,10),
                        blurRadius: 18.0,
                        color: mainColor.withOpacity(0.30),
                      ),
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: mainColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          //suffixIcon: SvgPicture.asset("assets/SplashScreen/Search.svg"),
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/SplashScreen/Search.svg"),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
