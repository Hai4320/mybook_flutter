

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/themes/styles.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../../resources/responsitory/user_repo.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final String _welcome = "Welcome to Mybooks";
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthBloc(userRepository: userRepository)..add(AppStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated){
            Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.secondary,
          body: SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    AppColors.secondary,
                    AppColors.primary,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Center(
                    child: SizedBox(
                      height: size.height * 0.7,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_welcome,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: size.height * 0.15,
                            ),
                            _buildButtonWithIcon(
                                "Login with your account",
                                size.width * 0.8,
                                Colors.white,
                                AppColors.blue,
                                null,
                                () => _clickLoginButton()),
                            _buildButtonWithIcon(
                                "Login with google",
                                size.width * 0.8,
                                Colors.black87,
                                Colors.white,
                                AppIcons.ic_google,
                                _clickLoginButton),
                            _buildButtonWithIcon(
                                "Login with facebook",
                                size.width * 0.8,
                                Colors.black87,
                                Colors.white,
                                AppIcons.ic_facebook,
                                _clickLoginButton),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.3,
                                    child: const Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
                                      child: Text(
                                        "or",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    child: const Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildButtonWithIcon(
                                "Create a new account!",
                                size.width * 0.8,
                                Colors.black87,
                                Colors.white,
                                null,
                                _clickSignupButton)
                          ],
                        ),
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }

  _clickLoginButton() {
    Navigator.pushNamed(context, "/login", arguments: 0);
  }

  _clickSignupButton() {
    Navigator.pushNamed(context, "/login", arguments: 1);
  }

  _buildButtonWithIcon(String title, double width, Color textColor,
      Color backgroundColor, String? icon, GestureTapCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(10)),
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        icon,
                        width: 20,
                        height: 20,
                      ),
                    ),
              Text(
                title,
                style: AppTextStyle.normal(15, textColor),
              ),
            ],
          )),
    );
  }
}
