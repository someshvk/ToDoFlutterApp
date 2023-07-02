import 'package:flutter/material.dart';

abstract class Styles {
  // dark mode colors
  static const Color darkBackgroundColor = Color.fromRGBO(19, 19, 26, 1);
  static const Color darkGridLinesColor = Color.fromRGBO(35, 40, 58, 0.776);
  static const Color darkInactiveTextColor = Color.fromRGBO(94, 93, 124, 1);
  static const Color darkActiveTextColor = Color.fromRGBO(190, 192, 216, 1);
  static const Color darkAppBarColor = Color.fromARGB(255, 5, 5, 8);
  static const Color darkPopUpMenuColor = Color.fromARGB(255, 33, 33, 51);

  // light mode colors
  static const Color lightBackgroundColor = Color.fromRGBO(239, 243, 255, 1);
  static const Color lightGridLinesColor = Color.fromRGBO(109, 112, 121, 0.238);
  static const Color lightInactiveTextColor = Color.fromRGBO(60, 69, 84, 0.847);
  static const Color lightActiveTextColor = Color.fromRGBO(21, 25, 31, 1);
  static const Color lightAppBarColor = Color.fromRGBO(185,197,215, 1);
  static const Color lightPopUpMenuColor = Color.fromARGB(255, 230, 230, 238);


  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Noto Sans Mono',

      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      appBarTheme: AppBarTheme(
        elevation: 1,
        backgroundColor: isDarkTheme ? darkAppBarColor : lightAppBarColor,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      ),
    );
  }
}