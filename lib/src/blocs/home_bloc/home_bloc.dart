import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  int type;
  int sort;
  HomeBloc({required this.type,required this.sort}): super(const HomeState(0,0)){
    on<HomeChangeTypeEvent>(_onHomeChangeTypeEvent);
    on<HomeChangeSortEvent>(_onHomeChangeSortEvent);
     
  } 
  void _onHomeChangeTypeEvent(event, Emitter<HomeState> emit) {
    type = event.type;
    emit(HomeState(type, sort));
  }
   void _onHomeChangeSortEvent(event, Emitter<HomeState> emit) {
    sort = event.sort;
    emit(HomeState(type, sort));
  }
}