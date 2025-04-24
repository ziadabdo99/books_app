import 'package:books_app/core/errors/failures.dart';
import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> fetchBooks({
    required int page,
    String? query,
  });
}