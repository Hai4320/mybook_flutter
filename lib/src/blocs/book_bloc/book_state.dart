import 'package:equatable/equatable.dart';
import 'package:mybook_flutter/src/models/book_model.dart';

abstract class BookState extends Equatable{
  const BookState();


  @override
  List<Object> get props => [];
}

class BookLoadingState extends BookState{}

class BookSuccessState extends BookState{
  final BookData books;
  
  const BookSuccessState({required this.books});

  @override
  List<Object> get props => [books];

}
class BookFailureState extends BookState{
  final String error;
  const BookFailureState({required this.error});
  @override
  List<Object> get props => [error];
}