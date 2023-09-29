import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static Color greenColor = const Color(0xffB7935F);
  static Color accentColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff383838))),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff5D9CEC),
    ),
  );
}