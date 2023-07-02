import 'package:flutter/material.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyButtons extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;
  MyButtons({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    
    return MaterialButton(
      onPressed: onPressed,
      color: themeManager.darkTheme ? Styles.darkInactiveTextColor : Styles.lightInactiveTextColor,
      child: Text(buttonName, style: TextStyle(fontSize: 20, color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor))
    );
  }
}