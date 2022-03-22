part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class UserInitEvent extends UserEvent {
  final UserRepository userRepository;
  const UserInitEvent({required this.userRepository});
  @override
  List<Object> get props => [userRepository];
}
class UserUpdateData extends UserEvent{
  final UserModel user;
  const UserUpdateData(this.user);
}
class UserChangeTabEvent extends UserEvent{
  final int tab;
  const UserChangeTabEvent({required this.tab});
}
