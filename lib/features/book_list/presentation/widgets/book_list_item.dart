import 'package:books_app/features/book_list/domain/entities/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatefulWidget {
  final Book book;
  const BookListItem({super.key, required this.book});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                _buildBookCover(),
                const SizedBox(width: 16),
                // Text Details
                Expanded(
                  child: _buildBookDetails(),
                ),
              ],
            ),
            // Expandable Summary
            _buildSummarySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        imageUrl: widget.book.imageUrl ?? '',
        width: 80,
        height: 120,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 80,
          height: 120,
          color: Colors.grey[200],
        ),
        errorWidget: (context, url, error) => Container(
          width: 80,
          height: 120,
          color: Colors.grey[300],
          child: const Icon(Icons.book_outlined),
        ),
      ),
    );
  }

  Widget _buildBookDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.book.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.book.authors.join(', '),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    if (widget.book.summary == null || widget.book.summary!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          widget.book.summary!,
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(
            _isExpanded ? 'See Less' : 'See More',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}