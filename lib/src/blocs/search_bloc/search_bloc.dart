import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String query;
  bool moveup;
  SearchBloc({required this.query,required this.moveup}) : super(SearchState(moveup, query)) {
      on<SearchMoveUpEvent>(_onSearchMoveUpEvent);
      on<SearchChangeQueryEvent>(_onSearchChangeQueryEvent);
  }
  void _onSearchMoveUpEvent(event, Emitter<SearchState> emit){
    moveup = event.moveup;
    emit(SearchState(moveup, query));
  }
  void _onSearchChangeQueryEvent(event, Emitter<SearchState> emit){
    query = event.query;
    emit(SearchState(moveup, query));
  }
}
