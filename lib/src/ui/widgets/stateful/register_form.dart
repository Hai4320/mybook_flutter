import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybook_flutter/src/blocs/register_bloc/register_bloc.dart';

import '../../../constants/app_localization.dart';
import '../../../constants/assets.dart';
import '../../themes/colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.func}) : super(key: key);
   final VoidCallback func;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var widthOfForm = size.width - 20;
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height - 80),
            ));
          }
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Create successfully! Login now'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: size.height - 80),
            ));
            await Future<void>.delayed(const Duration(milliseconds: 500));
            widget.func.call();
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            _handleOnChange() {
              BlocProvider.of<RegisterBloc>(context).add(RegisterFormChange(
                email: _emailController.text,
                name: _nameController.text,
                password: _passwordController.text,
                passwordConfirm: _passwordConfirmController.text,
              ));
            }

            _handleSubmit() {
              BlocProvider.of<RegisterBloc>(context).add(RegisterFormSubmit(
                  email: _emailController.text,
                  name: _nameController.text,
                  password: _passwordController.text,
                  passwordConfirm: _passwordConfirmController.text));
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      AppLocalizations.of(context).translate('REGISTER'),
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
                        onChanged: (value) => _handleOnChange(),
                        decoration: InputDecoration(
                            errorText: (state is RegisterFillFormState &&
                                    !state.isValidEmail)
                                ? "Email is not a valid"
                                : null,
                            hintText: "Enter Email Address",
                            enabled: state is! RegisterLoadingState,
                            labelText: "Email",
                            border: OutlineInputBorder()),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _nameController,
                        onChanged: (value) => _handleOnChange(),
                        decoration: InputDecoration(
                            errorText: (state is RegisterFillFormState &&
                                    !state.isValidName)
                                ? "UserName is not empty"
                                : null,
                            hintText: "Enter User Name",
                            labelText: "User Name",
                            enabled: state is! RegisterLoadingState,
                            border: OutlineInputBorder()),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        onChanged: (value) => _handleOnChange(),
                        decoration: InputDecoration(
                            errorText: (state is RegisterFillFormState &&
                                    !state.isValidPassword)
                                ? "Password is too short"
                                : null,
                            hintText: "Enter Password",
                            labelText: "Password",
                            enabled: state is! RegisterLoadingState,
                            border: OutlineInputBorder()),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        onChanged: (value) => _handleOnChange(),
                        decoration: InputDecoration(
                            errorText: (state is RegisterFillFormState &&
                                    !state.isValidConfirmPassword)
                                ? "Confirm password is not a valid"
                                : null,
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                            enabled: state is! RegisterLoadingState,
                            border: OutlineInputBorder()),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: state.canSubmit() 
                          ? _handleSubmit 
                          : null,
                        child: Container(
                            alignment: Alignment.center,
                            width: widthOfForm * 0.8,
                            child: Text(
                              state is RegisterLoadingState
                                  ? "Loading"
                                  : AppLocalizations.of(context)
                                      .translate('REGISTER'),
                            ))),
                  ),
                  InkWell(
                    onTap: widget.func,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).translate('have_account'),
                        style: TextStyle(color: AppColors.blue),
                      ),
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
