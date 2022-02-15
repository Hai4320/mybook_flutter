import 'package:flutter/material.dart';

class AppThemes{
  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange
  );
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange.shade700
  );
}