import 'package:flutter/material.dart';

TransparentAppBar(String title, Color color){
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold
      ), 
    ),
    centerTitle: true,
    foregroundColor: color,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );

}