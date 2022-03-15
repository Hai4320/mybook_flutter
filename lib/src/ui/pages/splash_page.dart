import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Future.delayed(const Duration(milliseconds: 500));
          Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
        } else{
           Future.delayed(const Duration(milliseconds: 1000));
           Navigator.pushNamedAndRemoveUntil(context, "/start", (route) => false);
        }
      },
      child: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.secondary,
                AppColors.primary,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child:
                  Center(child: LogoMyBooks(color: Colors.white, size: 25)))),
    );
  }
}
