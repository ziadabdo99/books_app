import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final int id;
  final String title;
  final List<String> authors;
  final String? imageUrl;
  final String? summary;

  const Book({
    required this.id,
    required this.title,
    required this.authors,
    this.imageUrl,
    this.summary,
  });

  @override
  List<Object?> get props => [id, title, authors, imageUrl, summary];
}