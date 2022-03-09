part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  int statusCode; 
  String message;
  UserModel user;

  LoggedIn({required this.statusCode,required this.message, required this.user});
  @override
  List<Object> get props => [statusCode,message,user];

  @override
  String toString() => 'LoggedIn { user: ${user.name} }';
}

class LoggedOut extends AuthEvent {}