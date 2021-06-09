import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sebarin/constants/themes/dark_theme.dart';

final darkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white),
  scaffoldBackgroundColor: DarkTheme.scaffoldBackgroundColor,
  backgroundColor: DarkTheme.scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    color: DarkTheme.dpLayer08,
    brightness: Brightness.dark,
    actionsIconTheme: IconThemeData(color: primaryColor),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  textTheme: GoogleFonts.latoTextTheme(),
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: primaryColor),
    brightness: Brightness.light,
    color: Colors.white,
    actionsIconTheme: IconThemeData(color: primaryColor),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);
