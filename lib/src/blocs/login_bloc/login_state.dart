
import 'package:equatable/equatable.dart';


abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState{
  LoginInitState();
}
class LoginLoadingState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}