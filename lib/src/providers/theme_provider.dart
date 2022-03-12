import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  get getThemeMode => _themeMode;
  initialize(){
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
  changeThemeMode(ThemeMode mode){
    _themeMode = mode;
  }
}