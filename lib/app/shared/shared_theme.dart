import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/theme.dart';

class SharedTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: bgRed),
    fontFamily: GoogleFonts.openSans().fontFamily,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xff2DA4FF),
    fontFamily: GoogleFonts.openSans().fontFamily,
  );

  static final titleTextStyle = GoogleFonts.lato().fontFamily;
}
