import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mybook_flutter/src/models/notification_model.dart';
import 'package:mybook_flutter/src/resources/responsitory/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository data;
  NotificationBloc({required this.data}) : super(NotificationInitial()) {
    on<NotificationFecthData>(_onFetchNotification);
  }
  _onFetchNotification(event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    List<NotificationModel> result = await data.fetchNotifications();
    if (result == [])
    { 
      emit(NotificationFailure());
    }
    else{
      data.notifications = result;
      emit(NotificationSuccess());
    }
    
  }

}
