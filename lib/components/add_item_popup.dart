// add_book_dialog.dart

import 'package:flutter/material.dart';
import 'package:library_management_app/book/book_model.dart';
import 'package:library_management_app/book/book_provider.dart';
import 'package:provider/provider.dart';
import 'my_textfield.dart';

void showAddBookDialog(BuildContext context) {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final yearController = TextEditingController();
  final isbnController = TextEditingController();
  final coverUrlController = TextEditingController();

  // key for validation
  final _addKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title:
            const Text('Add New Book', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            key: _addKey,
            children: [
              MyTextfield(
                label: "Title",
                controller: titleController,
                validator: (title) {
                  return null;
                },
              ),
              SizedBox(height: 10),
              MyTextfield(
                label: "Author",
                controller: authorController,
                validator: (author) {
                  return null;
                },
              ),
              SizedBox(height: 10),
              MyTextfield(
                label: "Published Year",
                controller: yearController,
                validator: (pYear) {
                  return null;
                },
              ),
              SizedBox(height: 10),
              MyTextfield(
                label: "ISBIN",
                controller: isbnController,
                validator: (isbin) {
                  return null;
                },
              ),
              SizedBox(height: 10),
              MyTextfield(
                label: "Cover Url",
                controller: coverUrlController,
                validator: (cUrl) {
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xffFF0000))),
          ),
          IconButton(
            onPressed: () {
              if (_addKey.currentState!.validate()) {
                final newBook = Book(
                  title: titleController.text,
                  author: authorController.text,
                  publishedYear: yearController.text,
                  isbn: isbnController.text,
                  coverUrl: coverUrlController.text,
                );
                Provider.of<BookProvider>(context, listen: false)
                    .addBook(newBook);
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.add,
              color: Color(0xff219e08),
            ),
          ),
        ],
      );
    },
  );
}
