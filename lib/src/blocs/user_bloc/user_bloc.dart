import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mybook_flutter/src/models/user_model.dart';
import 'package:mybook_flutter/src/resources/responsitory/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserModel user;
  int tab = 0;
  UserBloc({required this.user}) : super(UserState(user: user, tab: 0)) {
    on<UserInitEvent>(_onUserInitEvent);
    on<UserChangeTabEvent>(_onUserChangeTabEvent);
    on<UserUpdateData>(_onUserUpdateEvent);
  }
  void _onUserInitEvent(event, Emitter<UserState> emit) async{
    UserModel userLoad = await event.userRepository.getUserData();
    user = userLoad;
    emit(UserState(user: user, tab: tab));
  }
  void _onUserChangeTabEvent(event, Emitter<UserState> emit) async{
    tab = event.tab;
    emit(UserState(user: user, tab: tab));
  }
   void _onUserUpdateEvent(event, Emitter<UserState> emit) async{
    user = event.user;
    await user.getAvatarUrl();
    emit(UserState(user: user, tab: tab));
  }
}
