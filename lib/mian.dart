import 'package:flutter/material.dart';
import 'package:library_management_app/Auth/validation_page.dart';


void main() {
  runApp(const LibraryAdminApp());
}

class LibraryAdminApp extends StatelessWidget {
  const LibraryAdminApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValidationPage(),
    );
  }
}
