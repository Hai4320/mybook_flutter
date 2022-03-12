import 'package:flutter/material.dart';

class AppThemes{
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    fontFamily: "Nunito"
  );
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange.shade700,
    fontFamily: "Nunito",
    backgroundColor: Colors.grey[900],
    visualDensity: VisualDensity.adaptivePlatformDensity,

  );
}