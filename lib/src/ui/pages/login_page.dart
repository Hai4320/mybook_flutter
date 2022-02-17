import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:phlox_animations/phlox_animations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ], 
                begin: Alignment.topCenter, 
                end: Alignment.bottomCenter
              
              )
            ),
          child: Column(
            children: [
              Expanded(child: Container()),
              PhloxAnimations(
                duration: const Duration(milliseconds: 500),
                fromOpacity: 0,
                fromY: 500,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  height: size.height*0.85,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight:  Radius.circular(30)
                    )
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
