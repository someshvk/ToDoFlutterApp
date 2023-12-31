import 'package:flutter/material.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:flutter_application/utils/my_buttons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onAdd;
  VoidCallback onCancel;
  // ignore: prefer_typing_uninitialized_variables
  final hint;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onAdd,
      required this.onCancel,
      required this.hint});

  @override
  Widget build(BuildContext context) {

    final themeManager = Provider.of<ThemeManager>(context);
    
    return AlertDialog(
        backgroundColor: themeManager.darkTheme ? Styles.darkBackgroundColor : Styles.lightBackgroundColor,
        content: Builder(
          builder: (BuildContext context) {
            return SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: controller,
                    autofocus: true,
                    style: TextStyle(
                      color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor, 
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor, 
                        )
                      ), hintText: hint),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: MyButtons(buttonName: 'Add', onPressed: onAdd)),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child:
                          MyButtons(buttonName: 'Cancel', onPressed: onCancel))
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      );
  }
}
