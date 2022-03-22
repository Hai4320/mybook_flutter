part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUnknown extends AuthState {
  AuthUnknown();
}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}
class AuthUpdating extends AuthState {
  final UserModel user;
  AuthUpdating(this.user);
   @override
  List<Object> get props => [user];
}