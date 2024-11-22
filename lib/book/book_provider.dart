import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_management_app/book/book_model.dart';
import 'package:path_provider/path_provider.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => List.unmodifiable(_books);
  // List<bool> favoriteStatus = []; // Track favorite status for each book

  final List<Book> _searchResults = [];
  List<Book> get searchResults => List.unmodifiable(_searchResults);

  // Load data from file
  Future<void> loadBooks() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/books.json');

      if (file.existsSync()) {
        String jsonString = await file.readAsString();
        List<dynamic> jsonList = json.decode(jsonString);
        _books = jsonList.map((json) => Book.fromJson(json)).toList();
      }
    } catch (e) {
      // print("Error loading books: $e");
    }
    notifyListeners();
  }

  // Save books to file
  Future<void> saveBooks() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/books.json');
      String jsonString =
          json.encode(_books.map((book) => book.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      // print("Error saving books: $e");
    }
  }

  // add book fn
  void addBook(Book book) {
    _books.add(book);
    saveBooks();
    notifyListeners();
  }

  // update book fn
  void updateBook(int index, Book book) {
    _books[index] = book;
    saveBooks();
    notifyListeners();
  }

  // delete book fn
  void deleteBook(int index) {
    _books.removeAt(index);
    saveBooks();
    notifyListeners();
  }

  // search book fn
  void searchBooks(String query) {
    _searchResults.clear();
    _searchResults.addAll(_books.where((book) =>
        book.title.toLowerCase().contains(query.toLowerCase()) ||
        book.isbn.toLowerCase() == query.toLowerCase()));
    notifyListeners();
  }

  // fn for clear searchfield
  void clearSearch() {
    _searchResults.clear();
    _searchResults.addAll(_books); // Reset to all books after clearing search
    notifyListeners();
  }

  // navigation-related properties
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void updateTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // // Toggle favorite status
  // void toggleFavorite(int index) {
  //   favoriteStatus[index] = !favoriteStatus[index];
  //   notifyListeners();
  // }
}
