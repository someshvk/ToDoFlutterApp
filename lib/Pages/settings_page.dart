import 'package:flutter/material.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

   @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: themeManager.darkTheme ? Styles.darkBackgroundColor : Styles.lightBackgroundColor,
      appBar: AppBar(
        title: Text("Settings",
          style: TextStyle(color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor, fontSize: 27, fontWeight: FontWeight.w600)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 3.0, top: 3),
        child: Container(
          padding: const EdgeInsets.only(left: 9.0, top: 3),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 20, color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor)
                ),
                Transform.scale(
                  scale: 1,
                  child: Switch(
                    activeColor: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor,
                    value: themeManager.darkTheme,
                    onChanged: (newValue) {
                      themeManager.darkTheme = !themeManager.darkTheme;
                    },
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Font Style',
                  style: TextStyle(fontSize: 20, color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor)
                ),
                DropdownButton(
                  value: themeManager.selectedFont,
                  focusColor: themeManager.darkTheme ? Styles.darkPopUpMenuColor : Styles.lightPopUpMenuColor,
                  style: TextStyle(fontSize: 18, color: themeManager.darkTheme ? Styles.darkActiveTextColor : Styles.lightActiveTextColor),
                  onChanged: (String? value) {
                    themeManager.selectedFont = value!;
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Noto Sans Mono',
                      child: Text(
                        'Noto Sans',
                        style: TextStyle(fontSize: 18, color: themeManager.darkTheme? Styles.darkActiveTextColor : Styles.lightActiveTextColor)
                      )
                    ),
                      DropdownMenuItem(
                      value: 'Inter',
                      child: Text(
                        'Inter',
                        style: TextStyle(fontSize: 18, color: themeManager.darkTheme? Styles.darkActiveTextColor : Styles.lightActiveTextColor)
                      )),
                  ],
                )
              ],
            )
          ],)
        )
      )
    );
  }
}
