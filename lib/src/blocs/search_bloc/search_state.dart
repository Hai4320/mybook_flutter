part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool moveup;
  final String query;
  const SearchState(this.moveup, this.query);

  
  @override
  List<Object> get props => [moveup, query];
}

