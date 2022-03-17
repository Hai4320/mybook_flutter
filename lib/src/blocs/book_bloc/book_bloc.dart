import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_model.dart';
import '../../resources/responsitory/book_repo.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState>{
  BookRepository bookRepository;

  BookBloc({required this.bookRepository}) : super(BookLoadingState()){
    on<FetchBookEvent>(_onFetchBookEvent);
    on<ViewBookEvent>(_onViewBook);
    on<LikeBookEvent>(_onLikeBook);
    on<SaveBookEvent>(_onSaveBook);
  }
  void _onFetchBookEvent(event, Emitter<BookState> emit) async {
    emit(BookLoadingState());
    try{
      BookData? data = await bookRepository.getBooksByApi();
      if (data  is BookData) {
        emit(BookSuccessState(books: bookRepository.books));
      } else {
        emit(BookFailureState(error: bookRepository.message));
      }
    }catch (error) {
      emit(BookFailureState(error: bookRepository.message));
    }
  }
  void _onViewBook(event, Emitter<BookState> emit) async {
    emit(BookRefreshHistoryState(books: bookRepository.books));
    await bookRepository.viewBookAction(event.bookID);
    emit(BookSuccessState(books: bookRepository.books));
  }
  void _onLikeBook(event, Emitter<BookState> emit) async {
    emit(BookRefreshHistoryState(books: bookRepository.books));
    await bookRepository.likeBookAction(event.bookID, event.value);
    emit(BookSuccessState(books: bookRepository.books));
  }
  void _onSaveBook(event, Emitter<BookState> emit) async {
    emit(BookRefreshHistoryState(books: bookRepository.books));
    await bookRepository.saveBookAction(event.bookID, event.value);
    emit(BookSuccessState(books: bookRepository.books));
  }
}