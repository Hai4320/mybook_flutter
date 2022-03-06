import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/login_bloc/login_bloc.dart';
import '../../../blocs/login_bloc/login_event.dart';
import '../../../blocs/login_bloc/login_state.dart';
import '../../../constants/app_localization.dart';
import '../../../constants/assets.dart';
import '../../../resources/responsitory/user_repo.dart';
import '../../themes/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var widthOfForm = size.width - 20;

    return BlocProvider(
      create: (context) => LoginBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
          userRepository: userRepository),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async{
          if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height-80),
            ));
          }
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Login successfully !'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height-80),
            ));
            await Future<void>.delayed(const Duration(milliseconds: 500));
            Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            handleButtonPress() {
              print(_emailController.text);
              BlocProvider.of<LoginBloc>(context).add(LoginSubmited(
                email: _emailController.text,
                password: _passwordController.text,
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      AppLocalizations.of(context).translate('Login'),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                    height: 4,
                    indent: widthOfForm * 0.1,
                    endIndent: widthOfForm * 0.1,
                    thickness: 1,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: TextFormField(
                        controller: _emailController,
                        enabled: state is! LoginLoadingState,
                        onChanged: (value)=> BlocProvider.of<LoginBloc>(context).add(LoginFormChanged(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )),
                        decoration: InputDecoration(
                          errorText: (state is LoginInvalidState&&state.isInvalidEmail)? "Email is invalid" :null,
                            hintText: "Email",
                            labelText: "Email",
                            border: const OutlineInputBorder()),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        enabled: state is! LoginLoadingState,
                        onChanged: (value)=> BlocProvider.of<LoginBloc>(context).add(LoginFormChanged(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )),
                        decoration: InputDecoration(
                            errorText: (state is LoginInvalidState&&state.isInvalidPassword)? "Password too short": null,
                            hintText: "Password",
                            labelText: "Password",
                            border: const OutlineInputBorder()),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: ElevatedButton(

                        onPressed: (state is! LoginLoadingState)
                            ? handleButtonPress
                            : null,
                        child: Container(
                            alignment: Alignment.center,
                            width: widthOfForm * 0.8,
                            child: Text(
                              state is LoginLoadingState? "Loading":
                              AppLocalizations.of(context).translate('LOGIN'),
                            ))),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).translate('forgot_password'),
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Divider(
                      color: Colors.black54,
                      height: 4,
                      indent: widthOfForm * 0.2,
                      endIndent: widthOfForm * 0.2,
                      thickness: 1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () {},
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: const [
                                  //BoxShadow
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 3.0,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 3.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child: Image.asset(AppIcons.ic_google)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () {},
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: const [
                                  //BoxShadow
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 3.0,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 3.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child: Image.asset(AppIcons.ic_facebook)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
