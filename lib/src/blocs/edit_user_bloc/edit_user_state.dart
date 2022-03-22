part of 'edit_user_bloc.dart';

abstract class EditUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserEditingState extends EditUserState {}

class UserCheckingState extends UserEditingState {}

class EditUserLoading extends EditUserState {}

class EditUserChangingImage extends EditUserState {}

class EditUserFailure extends EditUserState {
  final String message;
  EditUserFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class EditUserSuccess extends EditUserState {}
