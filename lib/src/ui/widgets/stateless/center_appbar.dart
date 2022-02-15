import 'package:flutter/material.dart';

class CenterAppBar extends StatelessWidget {
  String title;
  CenterAppBar({ Key? key , required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
    );
  }
}