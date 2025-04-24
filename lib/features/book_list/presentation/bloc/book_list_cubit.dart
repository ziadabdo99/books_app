import 'package:books_app/features/book_list/domain/usecases/fetch_books.dart';
import 'package:books_app/features/book_list/presentation/bloc/book_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListCubit extends Cubit<BookListState> {
  final FetchBooksUseCase fetchBooksUseCase;
  int currentPage = 1;
  String? currentQuery;

  BookListCubit({required this.fetchBooksUseCase})
      : super(const BookListInitial());

  Future<void> fetchBooks({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        currentPage = 1;
        emit(const BookListLoading());
      }

      final result = await fetchBooksUseCase(
        page: currentPage,
        query: currentQuery,
      );

      result.fold(
        (failure) => emit(BookListError(failure.message)),
        (books) {
          currentPage++;
          emit(BookListLoaded(
            books: loadMore
                ? (state as BookListLoaded).books + books
                : books,
            hasReachedMax: books.isEmpty,
          ));
        },
      );
    } catch (e) {
      emit(BookListError('Failed to load books'));
    }
  }

void searchBooks(String query) {
  if (query.isEmpty) return;
  currentQuery = query;
  currentPage = 1;
  fetchBooks();
}
}