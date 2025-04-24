import 'package:books_app/core/errors/failures.dart';
import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:books_app/features/book_list/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';



class FetchBooksUseCase {
  final BookRepository repository;

  FetchBooksUseCase(this.repository);

  Future<Either<Failure, List<Book>>> call({
    required int page,
    String? query,
  }) async {
    return await repository.fetchBooks(page: page, query: query);
  }
}