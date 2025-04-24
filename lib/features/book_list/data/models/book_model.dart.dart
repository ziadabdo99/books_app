// lib/features/book_list/data/models/book_model.dart
import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final int id;
  final String title;
  final List<String> authors;
  final String? imageUrl;
  final String? summary;

  const BookModel({
    required this.id,
    required this.title,
    required this.authors,
    this.imageUrl,
    this.summary,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled',
      authors: _parseAuthors(json['authors']),
      imageUrl: _parseImageUrl(json['formats']),
      summary: _parseSummary(json['subjects']),
    );
  }

  static List<String> _parseAuthors(List<dynamic>? authors) {
    if (authors == null) return [];
    return authors
        .map<String>((author) => author['name']?.toString() ?? 'Unknown Author')
        .toList();
  }

  static String? _parseImageUrl(Map<String, dynamic>? formats) {
    if (formats == null) return null;
    return formats['image/jpeg']?.toString() ?? formats['image/png']?.toString();
  }

  static String? _parseSummary(List<dynamic>? subjects) {
    if (subjects == null || subjects.isEmpty) return null;
    return subjects.join(', ');
  }

  Book toEntity() => Book(
        id: id,
        title: title,
        authors: authors,
        imageUrl: imageUrl,
        summary: summary,
      );

  @override
  List<Object?> get props => [id, title, authors, imageUrl, summary];
}