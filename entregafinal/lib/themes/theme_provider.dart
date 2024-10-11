import 'package:flutter/material.dart';
import 'themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool _inDarkMode = false;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  bool get inDarkMode => _inDarkMode;

  set inDarkMode(bool inDarkMode) {
    _inDarkMode = inDarkMode;
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      inDarkMode = true;
    } else {
      themeData = lightMode;
      inDarkMode = false;
    }
  }
}