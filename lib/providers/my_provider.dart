import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/userModel.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  String languageCode = "en";

  ThemeMode modeApp = ThemeMode.light;

  bool isLight() => modeApp == ThemeMode.light;

  UserModel? userModel;

  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel =
        await FirebaseFunctions.readUserFromFirestore(firebaseUser!.uid);
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    languageCode = langCode;
    notifyListeners();
  }

  void changeTheme(ThemeMode mode) {
    modeApp = mode;
    notifyListeners();
  }
}
