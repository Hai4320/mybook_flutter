import 'package:flutter/material.dart';

class LoadingUI extends StatelessWidget {
  const LoadingUI({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}