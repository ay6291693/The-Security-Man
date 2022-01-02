import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: 'The Security Man',
      theme: ThemeData(
             //We set poppins as are default font
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

 /* MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Details Page',
theme: ThemeData(
//We set poppins as are default font
textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
primaryColor: kPrimaryColor,
accentColor: kPrimaryColor,
visualDensity: VisualDensity.adaptivePlatformDensity,
),

 ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Theme.of(context).primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      )
      */