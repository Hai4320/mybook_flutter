
import 'package:equatable/equatable.dart';

import '../../constants/validator.dart';


abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState{
  LoginInitState();
}
class LoginInvalidState extends LoginState {
  final bool isInvalidEmail;
  final bool isInvalidPassword;
  const  LoginInvalidState({required this.isInvalidEmail, required this.isInvalidPassword});

   @override
  List<Object> get props => [isInvalidEmail, isInvalidPassword];


}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}