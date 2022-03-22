part of 'edit_user_bloc.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object> get props => [];
}

class EditUserChangeImageEvent extends EditUserEvent {}

class EditUserChangeNameEvent extends EditUserEvent {
  final String value;
  const EditUserChangeNameEvent({required this.value});
  @override
  List<Object> get props => [value];
}

class EditUserEnableChangePasswordEvent extends EditUserEvent {}

class EditUserUploadImageEvent extends EditUserEvent {}

class EditUserChangeNewPasswordEvent extends EditUserEvent {
  final String value;
  const EditUserChangeNewPasswordEvent({required this.value});
  @override
  List<Object> get props => [value];
}

class EditUserSummitEvent extends EditUserEvent {
  final String name;
  final String newPassword;
  final String oldPassword;
  const EditUserSummitEvent(
      {required this.name,
      required this.newPassword,
      required this.oldPassword,
      });
}
