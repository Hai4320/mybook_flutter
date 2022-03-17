part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterFormChange extends RegisterEvent {
  final String email;
  final String name;
  final String password;
  final String passwordConfirm;
  const RegisterFormChange({required this.email, required this.name, required this.password, required this.passwordConfirm});
  @override
  List<Object> get props => [email, name, password, passwordConfirm];
}
class RegisterFormSubmit extends RegisterEvent{
  final String email;
  final String name;
  final String password;
  final String passwordConfirm;
  const RegisterFormSubmit({required this.email, required this.name, required this.password, required this.passwordConfirm});
  @override
  List<Object> get props => [email, name, password, passwordConfirm];
}
