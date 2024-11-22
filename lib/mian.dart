import 'package:flutter/material.dart';
import 'package:library_management_app/book/pages/book_pages.dart';
import 'package:library_management_app/book/book_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BookPages(),
      ),
    );
  }
}
