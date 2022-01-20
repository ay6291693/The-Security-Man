import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/contents.dart';
import 'package:thesecurityman/homepage.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Container builtDot(int index, BuildContext context) {
    return Container(
      height: 12,
      width: currentIndex == index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.deepOrange),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Security Man"),
        backgroundColor: mainColor,
        toolbarHeight: 70,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Lottie.asset(
                          contents[i].image,
                          height: 250,
                          width: 250
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          contents[i].title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Hina'
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                contents[i].description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 20, color: Colors.black,fontFamily: 'Hina'),
                              ),
                            ))

                      ],
                    ));
              },
            ),
          ),
          Container(
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                      (index) => builtDot(index, context),
                ),
              )
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: FlatButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
                _controller.nextPage(
                    duration: Duration(microseconds: 10000),
                    curve: Curves.bounceIn);
              },
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              color: mainColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          )
        ],
      ),
    );
  }
}
