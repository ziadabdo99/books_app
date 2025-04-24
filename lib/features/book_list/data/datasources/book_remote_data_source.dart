import 'dart:convert';

import 'package:books_app/core/errors/exceptions.dart';
import 'package:books_app/features/book_list/data/models/book_model.dart.dart';
import 'package:http/http.dart' as http;


class BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSource({required this.client});

  Future<List<BookModel>> fetchBooks({int page = 1, String? query}) async {
    try {
      final uri = Uri.https('gutendex.com', '/books', {
        'page': '$page',
        if (query != null) 'search': query,
      });

      final response = await client.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<BookModel>.from(
            data['results'].map((x) => BookModel.fromJson(x)));
      } else {
        throw ServerException(
          message: 'Failed to load books',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException {
      throw NetworkException();
    }
  }
}