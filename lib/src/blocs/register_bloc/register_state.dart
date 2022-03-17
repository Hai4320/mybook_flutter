part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();

  bool canSubmit() => false;
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterFillFormState extends RegisterState{
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidName;
  final bool isValidConfirmPassword;
  const RegisterFillFormState({required this.isValidEmail, required this.isValidPassword,required this.isValidConfirmPassword, required this.isValidName});
  
  @override
  bool canSubmit(){
    return (isValidEmail && isValidPassword&& isValidName && isValidConfirmPassword);
  }
  
  @override
  List<Object> get props => [isValidEmail, isValidPassword, isValidName, isValidConfirmPassword];
}

class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  final String error;
  const RegisterErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
