import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:mybook_flutter/src/constants/validator.dart';
import 'package:mybook_flutter/src/resources/service/api.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterFormSubmit>(_onRegisterSummited);
    on<RegisterFormChange>(_onRegisterFormChanged);
  }
  void _onRegisterSummited(event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterLoadingState());
      var res = await http.post(
        Uri.parse(AppApis.register_API),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({ 
          "email": event.email, 
          "name": event.name,
          "password": event.password,
        })
      );
      var body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        emit(RegisterSuccessState());
      }
      else{
        emit(RegisterErrorState(error: body["message"]));
      }
    } catch (error) {
      print(error);
      emit(RegisterErrorState(error: "Something went wrong"));
    }
  }

  void _onRegisterFormChanged(event, Emitter<RegisterState> emit) async {
    bool isValidEmail = Validation.isValidEmail(event.email);
    bool isValidPassword= Validation.isValidPassword(event.password);
    bool isValidConfirmPassword = event.password == event.passwordConfirm;
    bool isValidName = Validation.isValidName(event.name);
    emit(RegisterFillFormState(
      isValidEmail: isValidEmail, 
      isValidPassword: isValidPassword, 
      isValidName: isValidName,
      isValidConfirmPassword: isValidConfirmPassword
    ));
  }
}
