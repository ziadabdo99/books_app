import 'package:books_app/core/errors/exceptions.dart';
import 'package:books_app/core/errors/failures.dart';
import 'package:books_app/features/book_list/data/datasources/book_remote_data_source.dart';
import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:books_app/features/book_list/domain/repositories/book_repository.dart';

import 'package:dartz/dartz.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Book>>> fetchBooks({
    required int page,
    String? query,
  }) async {
    try {
      final bookModels = await remoteDataSource.fetchBooks(
        page: page,
        query: query,
      );
      return Right(bookModels.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}