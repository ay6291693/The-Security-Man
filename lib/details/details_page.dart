import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thesecurityman/constants.dart';
import 'package:thesecurityman/details/components/CompanyDetailPage.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Details Page',
      theme: ThemeData(
        //We set poppins as are default font
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CompanyDetailPageBody(),
    );
  }
}
