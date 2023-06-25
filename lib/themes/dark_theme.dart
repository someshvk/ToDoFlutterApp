import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.notoSansMono().fontFamily,
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(29, 29, 40, 1),
    primary: Color.fromRGBO(46, 53, 78, 1),
    secondary: Color.fromRGBO(114, 134, 169, 1),
    tertiary: Color.fromRGBO(204, 215, 234, 1)
  ),
);