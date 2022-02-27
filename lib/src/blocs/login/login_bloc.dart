import 'dart:async';

import '../../data/validator.dart';
import '../base_bloc.dart';

class LoginBloc implements BaseBloc {
  StreamController _emailController = StreamController();
  StreamController _passController = StreamController();

  Stream get email => _emailController.stream;

  bool isValidInput(String email, String password){
    if (Validation.isValidEmail(email)) {
      _emailController.sink.addError("Email is not valid!");
      return false;
    }
    if (Validation.isValidPassword(password)) {
      _passController.sink.addError("Password is not valid!");
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _emailController.close();
    _passController.close();
  }
}