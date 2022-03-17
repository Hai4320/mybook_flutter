part of 'book_bloc.dart';

abstract class BookEvent extends Equatable{
  const BookEvent();

  @override
  List<Object> get props => [];
}

class FetchBookEvent extends BookEvent{}

class ReloadBookEvent extends BookEvent{}

class LikeBookEvent extends BookEvent{
  final String bookID;
  final bool value;
  const LikeBookEvent({required this.bookID,required this.value});
  @override
  List<Object> get props => [bookID,value];
}
class SaveBookEvent extends BookEvent{
  final String bookID;
  final bool value;
  const SaveBookEvent({required this.bookID,required this.value});
  @override
  List<Object> get props => [bookID,value];
}

class ViewBookEvent extends BookEvent{
  final String bookID;
  const ViewBookEvent({required this.bookID});
  @override
  List<Object> get props => [bookID];
}
