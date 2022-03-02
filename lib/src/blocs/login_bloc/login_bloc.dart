import 'package:mybook_flutter/src/blocs/login_bloc/login_event.dart';
import 'package:mybook_flutter/src/blocs/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../resources/responsitory/user_repo.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;
  LoginBloc({
    required this.userRepository,
    required this.authBloc,
  }) : super(LoginInitState()) {
    on<LoginSubmited>(_onLoginSummited);
  }

  void _onLoginSummited(event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      final data = await userRepository.login(
        event.email,
        event.password,
      );
      print(data);
      if (data["statusCode"] == 200) {
        authBloc.add(LoggedIn(
            statusCode: data["statusCode"],
            message: data["message"],
            user: data["user"]));
        emit(LoginInitState());
      } else {
        emit(LoginFailureState(error: data["message"]));
      }
    } catch (error) {
      emit(LoginFailureState(error: error.toString()));
    }
  }
}
