import 'package:books_app/features/book_list/presentation/bloc/book_list_cubit.dart';
import 'package:books_app/features/book_list/presentation/bloc/book_list_state.dart';
import 'package:books_app/features/book_list/presentation/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BookSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<BookListCubit, BookListState>(
      builder: (context, state) {
        final cubit = context.read<BookListCubit>();
        
        if (query.isNotEmpty) {
          cubit.searchBooks(query);
        }

        if (state is BookListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookListError) {
          return Center(child: Text(state.message));
        } else if (state is BookListLoaded) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                cubit.fetchBooks(loadMore: true);
              }
              return true;
            },
            child: ListView.builder(
              itemCount: state.books.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.books.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BookListItem(book: state.books[index]);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}