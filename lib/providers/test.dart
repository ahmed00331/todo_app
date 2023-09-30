import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int index = 0;

  onTap(value) {
    index = value;
    notifyListeners();
  }
}
