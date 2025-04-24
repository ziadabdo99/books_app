import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:equatable/equatable.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object?> get props => [];
}

class BookListInitial extends BookListState {
  const BookListInitial();
}

class BookListLoading extends BookListState {
  const BookListLoading();
}

class BookListLoaded extends BookListState {
  final List<Book> books;
  final bool hasReachedMax;

  const BookListLoaded({
    required this.books,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [books, hasReachedMax];
}

class BookListError extends BookListState {
  final String message;

  const BookListError(this.message);

  @override
  List<Object?> get props => [message];
}