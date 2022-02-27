import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateful/login_form.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/logo.dart';
import 'package:phlox_animations/phlox_animations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColors.primary,
              AppColors.secondary,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: size.height * 0.1,
                  child: Center(
                    child: LogoMyBooks(color: null, size: 25)
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: BackClipper(),
                    child: Container(
                      height: size.height * 0.5,
                      color: Colors.white,
                ))),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: PhloxAnimations(
                    duration: const Duration(milliseconds: 500),
                    fromOpacity: 0,
                    fromY: 500,
                    child: Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        height: size.height * 0.85,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                            ),
                            boxShadow: [//BoxShadow
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                spreadRadius: 3.0,
                              ), //BoxShadow
                            ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: LoginForm()
                            ),
                            Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: _buildTabBar()
                            )
                          ],
                        )
                      ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _buildTabBar() {
    var size = MediaQuery.of(context).size;
    double borderRadius = 10;
    var width = size.width*0.6;
    double height = 50;
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            RawMaterialButton(
              onPressed: (){},
              child: Container(
                width: width/2-1,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    bottomLeft: Radius.circular(borderRadius)
                  )
                ),
                child: Text("Login"),
              ),
            ),
            RawMaterialButton(
              onPressed: (){},
              child: Container(
                alignment: Alignment.center,
                width: width/2-1,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius)
                  )
                ),
                child: Text("Register"),
              ),
            ),
          ],
        ),
      );
  }
}

class BackClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    //shape lower wave 1
    path.lineTo(0,2*sh/5);
    path.quadraticBezierTo(sw/2,0,sw, 2*sh/5);
    path.lineTo(sw,sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}