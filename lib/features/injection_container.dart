import 'package:books_app/features/book_list/data/datasources/book_remote_data_source.dart';
import 'package:books_app/features/book_list/data/repositories/book_repository_impl.dart';
import 'package:books_app/features/book_list/domain/repositories/book_repository.dart';
import 'package:books_app/features/book_list/domain/usecases/fetch_books.dart';
import 'package:books_app/features/book_list/presentation/bloc/book_list_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
sl.registerLazySingleton(() => BookListCubit(fetchBooksUseCase: sl()));
  // Use cases
  sl.registerLazySingleton(() => FetchBooksUseCase(sl()));

  // Repository
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSource(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}