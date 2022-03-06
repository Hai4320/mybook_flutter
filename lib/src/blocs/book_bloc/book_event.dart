import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable{
  const BookEvent();

  @override
  List<Object> get props => [];
}

class FetchBookEvent extends BookEvent{}

class ReloadBookEvent extends BookEvent{}