part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final int statusCode; 
  final String message;
  final UserModel user;

  const LoggedIn({required this.statusCode,required this.message, required this.user});
  @override
  List<Object> get props => [statusCode,message,user];

  @override
  String toString() => 'LoggedIn { user: ${user.name} }';
}

class LoggedOut extends AuthEvent {}
class ReloadUser extends AuthEvent {
  final UserModel user;
  const ReloadUser(this.user);
}