part of 'search_bloc.dart';

class SearchState extends Equatable {
  bool moveup;
  String query;
  SearchState(this.moveup, this.query);

  
  @override
  List<Object> get props => [moveup, query];
}

