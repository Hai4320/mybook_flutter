import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginFormChanged extends LoginEvent {
  final String email;
  final String password;

  const LoginFormChanged({required this.email,required this.password});
}


class LoginSubmited extends LoginEvent {
  final String email;
  final String password;
  const LoginSubmited({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];

}