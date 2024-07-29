import 'package:flutter/material.dart';

class ThemeLogic extends ChangeNotifier {
  int _theme = 0; //0: system, 1: light, 2: dark
  int get theme => _theme;

  void changeToSystem() {
    _theme = 0;
    notifyListeners();
  }

  void changeToLight() {
    _theme = 1;
    notifyListeners();
  }

  void changeToDark() {
    _theme = 2;
    notifyListeners();
  }
}
