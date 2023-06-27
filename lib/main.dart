import 'package:flutter/material.dart';
import 'package:flutter_application/themes/dark_theme.dart';
import 'package:flutter_application/utils/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Pages/home_page.dart';
import 'Pages/settings_page.dart';

void main() async {

  // initialize hive local database
  await Hive.initFlutter();

  // open a hive box
  // ignore: unused_local_variable
  var box = await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      initialRoute: '/home',
      routes: {
        '/' : (context) => const HomePage(),
        MyRoutes.homeRoute : (context) => const HomePage(),
        MyRoutes.settingRoute : (context) => SettingsPage(onChanged: (value) => {})
      }
    );
  }
}