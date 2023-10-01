import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String languageCode = "en";

  ThemeMode modeApp = ThemeMode.light;

  void changeLanguage(String langCode) {
    languageCode = langCode;
    notifyListeners();
  }

  void changeTheme(ThemeMode mode) {
    modeApp = mode;
    notifyListeners();
  }
}
