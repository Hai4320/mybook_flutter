abstract class LoginEvent {}

class LoginFormChanged extends LoginEvent {
  final String email;
  final String password;

  LoginFormChanged({required this.email,required this.password});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmited extends LoginEvent {
  final String email;
  final String password;
  LoginSubmited({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginButtonPressed { email: $email, password: $password }';
}