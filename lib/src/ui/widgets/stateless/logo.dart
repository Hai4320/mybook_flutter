import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoMyBooks extends StatelessWidget {
  Color? color;
  double size;
  LogoMyBooks({ Key? key, required this.color,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String logo = "MyBooks";
    return Text(
      logo,
      style: TextStyle(
        color: color?? Colors.white,
        fontSize: size,
        fontWeight: FontWeight.bold
      ),
    );
  }
}