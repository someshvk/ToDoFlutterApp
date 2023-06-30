import 'package:flutter/foundation.dart';
import 'package:flutter_application/utils/dark_theme_prefrences.dart';

class ThemeManager with ChangeNotifier {
  DarkThemePreference darkThemePreferences = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }
}