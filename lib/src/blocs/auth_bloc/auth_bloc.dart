import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../resources/responsitory/user_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthUnknown()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(event, Emitter<AuthState> emit) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    bool isLogined = await userRepository.isLogined();
    if (isLogined) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    userRepository.setLoginData(true,event.user);
    emit(AuthAuthenticated());
  }

  void _onLoggedOut(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.deleteLoginData();
    emit(AuthUnauthenticated());
  }
}
