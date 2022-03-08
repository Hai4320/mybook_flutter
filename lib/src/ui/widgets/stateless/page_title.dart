import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({ Key? key , required this.title, required this.color}) : super(key: key);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        title, 
        style: TextStyle(
          color: color,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        )
    );
  }
}