import './themes.dart';

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(String selected) {
    if (selected == 'lightMode') {
      themeData = lightMode;
    } else if (selected == 'darkMode') {
      themeData = darkMode;
    }
  }
}
