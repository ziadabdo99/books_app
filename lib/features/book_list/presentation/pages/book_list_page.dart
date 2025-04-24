import 'package:books_app/features/book_list/presentation/bloc/book_list_cubit.dart';
import 'package:books_app/features/book_list/presentation/bloc/book_list_state.dart';
import 'package:books_app/features/book_list/presentation/widgets/book_list_item.dart';
import 'package:books_app/features/book_list/presentation/widgets/book_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutenberg Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: BookSearchDelegate(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BookListCubit, BookListState>(
        builder: (context, state) {
          if (state is BookListInitial) {
            return const Center(child: Text('Search for books'));
          } else if (state is BookListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookListError) {
            return Center(child: Text(state.message));
          } else if (state is BookListLoaded) {
            return ListView.builder(
              itemCount: state.books.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.books.length) {
                  context.read<BookListCubit>().fetchBooks(loadMore: true);
                  return const Center(child: CircularProgressIndicator());
                }
                return BookListItem(book: state.books[index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}