import 'package:mybook_flutter/src/blocs/login_bloc/login_event.dart';
import 'package:mybook_flutter/src/blocs/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/validator.dart';
import '../../resources/responsitory/user_repo.dart';
import '../auth_bloc/auth_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  LoginBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(const LoginInitState()) {
    on<LoginSubmited>(_onLoginSummited);
    on<LoginFormChanged>(_onLoginFormChanged);
  }

  void _onLoginSummited(event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final data = await userRepository.login(
        event.email,
        event.password,
      );
      if (data["statusCode"] == 200) {
        authBloc.add(LoggedIn(
            statusCode: data["statusCode"],
            message: data["message"],
            user: data["user"]));
        await Future<void>.delayed(const Duration(milliseconds: 500));
        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState(error: data["message"]));
      }
    } catch (error) {
      emit(LoginFailureState(error: error.toString()));
    }
  }

  void _onLoginFormChanged(event, Emitter<LoginState> emit) async {
    if (state is LoginLoadingState) return;
    bool invalidEmail = false;
    bool invalidPassword = false;
    if (!Validation.isValidEmail(event.email)) invalidEmail = true;
    if (!Validation.isValidPassword(event.password)) invalidPassword = true;
    if (invalidEmail || invalidPassword) {
      emit(LoginInvalidState(
          isInvalidEmail: invalidEmail, 
          isInvalidPassword: invalidPassword
        )
      );
    } else {
      emit(const LoginInitState());
    }
    
  }
}
