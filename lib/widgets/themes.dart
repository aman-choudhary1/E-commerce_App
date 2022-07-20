import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        buttonColor: Darkbluish,
        accentColor: Darkbluish,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: Theme.of(context).textTheme,
        ),
      );
  static ThemeData darkTheme(BuildContext context) => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.dark,
        cardColor: Colors.black,
        canvasColor: DarkCreamColor,
        buttonColor: lightBluish,
        accentColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.copyWith(
              headline6:
                  context.textTheme.headline6.copyWith(color: Colors.white)),
        ),
      );
  static Color creamColor = Color(0xfff5f5f5);
  static Color DarkCreamColor = Vx.gray900;
  static Color Darkbluish = Color(0xff403b58);
  static Color lightBluish = Vx.indigo600;
}
