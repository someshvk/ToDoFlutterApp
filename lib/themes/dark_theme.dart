import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Noto Sans Mono',
  //fontFamily: GoogleFonts.notoSansMono().fontFamily,
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(19, 19, 26, 1),
    primary: Color.fromRGBO(35, 40, 58, 0.776),
    secondary: Color.fromRGBO(94, 93, 124, 1),
    tertiary: Color.fromRGBO(190, 192, 216, 1)
  )
);