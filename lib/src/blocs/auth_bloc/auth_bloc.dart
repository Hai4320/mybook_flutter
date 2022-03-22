import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mybook_flutter/src/models/user_model.dart';

import '../../resources/responsitory/user_repo.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthUnknown()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<ReloadUser>(_onReloadUser);
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
    await userRepository.setLoginData(true,event.user);
    await userRepository.isLogined();
    emit(AuthAuthenticated());
  }

  void _onLoggedOut(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await userRepository.deleteLoginData();
    emit(AuthUnauthenticated());
  }
   void _onReloadUser(event, Emitter<AuthState> emit) async {
    emit(AuthUpdating(event.user));
    await userRepository.updateUserData(event.user);
    emit(AuthAuthenticated());
  }
}
