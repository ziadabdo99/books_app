import 'package:books_app/features/book_list/presentation/bloc/book_list_cubit.dart';
import 'package:books_app/features/book_list/presentation/pages/book_list_page.dart';
import 'package:books_app/features/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookListCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gutenberg Books',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BookListPage(),
      ),
    );
  }
}