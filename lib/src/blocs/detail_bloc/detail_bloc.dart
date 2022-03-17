import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/models/book_model.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  BookModel book;
  BookBloc bookBloc;
  DetailBloc({required this.book, required this.bookBloc}) : super(DetailState(book: book)) {
    on<DetailOpenEvent>(_onDetailOpen);
    on<DetailLikeEvent>(_onDetailLike);
    on<DetailSaveEvent>(_onDetailSave);
  }
  void _onDetailOpen(event, Emitter<DetailState> emit) async {
    if (book.isViewed == false) {
      book.isViewed = true;
      book.view++;
      bookBloc.add(ViewBookEvent(bookID: book.id));
    }
    emit(DetailState(book: book));
  }
  void _onDetailLike(event, Emitter<DetailState> emit) async {
    emit(DetailLoadState(book: book));
    if (book.isLiked==false) {
      book.isLiked = true;
      book.like++;
    }
    else{
      book.isLiked = false;
      book.like--;
    }
    emit(DetailState(book: book));
    bookBloc.add(LikeBookEvent(bookID: book.id, value: !book.isLiked));
  }
  void _onDetailSave(event, Emitter<DetailState> emit) async {
    emit(DetailLoadState(book: book));
    if (book.isSaved==false) {
      book.isSaved = true;
    } else {
      book.isSaved = false;
    }
    emit(DetailState(book: book));
    bookBloc.add(SaveBookEvent(bookID: book.id, value: !book.isLiked));
  }
  
}
