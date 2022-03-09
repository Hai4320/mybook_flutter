part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMoveUpEvent extends SearchEvent {
  final bool moveup;
  const SearchMoveUpEvent(this.moveup);

  @override
  List<Object> get props => [moveup];
}

class SearchChangeQueryEvent extends SearchEvent{
  final String query;
  const SearchChangeQueryEvent(this.query);
  @override
  List<Object> get props => [query];
  

}
