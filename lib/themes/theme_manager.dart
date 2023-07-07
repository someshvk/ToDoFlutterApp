import 'package:flutter/foundation.dart';
import 'package:flutter_application/utils/dark_theme_prefrences.dart';

class ThemeManager with ChangeNotifier {
  DarkThemePreference darkThemePreferences = DarkThemePreference();
  bool _darkTheme = false;
  String _selectedFont = 'Inter';

  bool get darkTheme => _darkTheme;
  String get selectedFont => _selectedFont;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreferences.setDarkTheme(value);
    notifyListeners();
  }

  set selectedFont(String value) {
      _selectedFont = value;
      notifyListeners();
    }
}