part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final BookModel book;
  const DetailState({required this.book});
  
  @override
  List<Object> get props => [book];
}

class DetailLoadState extends DetailState{
  const DetailLoadState({required BookModel book}) : super(book: book);
}

