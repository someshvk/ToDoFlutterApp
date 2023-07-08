import 'package:flutter/material.dart';
import 'package:flutter_application/themes/style.dart';
import 'package:flutter_application/themes/theme_manager.dart';
import 'package:flutter_application/utils/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Pages/home_page.dart';
import 'Pages/settings_page.dart';
import 'package:provider/provider.dart';

void main() async {

  // initialize hive local database
  await Hive.initFlutter();

  // open a hive box
  // ignore: unused_local_variable
  var box = await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeManager themeChangeProvider = ThemeManager();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }


  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<ThemeManager>(
          builder: (BuildContext context, value, Widget? child) {
            return MaterialApp( 
              showPerformanceOverlay: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, themeChangeProvider.selectedFont, context),
              initialRoute: '/',
              routes: {
                MyRoutes.homeRoute : (context) => const HomePage(),
                MyRoutes.settingRoute : (context) => const SettingsPage()
              }
            );
          },
        ),
      );
  }
}