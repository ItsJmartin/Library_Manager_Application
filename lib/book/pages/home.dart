import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management_app/components/costom_heading.dart';
import 'package:library_management_app/components/search_field.dart';
import 'package:provider/provider.dart';
import '../book_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  BookPageState createState() => BookPageState();
}

class BookPageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load books when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure loadBooks is called after the first frame is built
      Provider.of<BookProvider>(context, listen: false).loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/booksback.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border.all(
                      width: 2,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 35, 16, 16),
              child: Column(
                children: [
                  // custom heading
                  MyHeading(heading: "World Of Books"),

                  const SizedBox(height: 20), //gap between content

                  // custom searchfield
                  MySearchField(
                    controller: _searchController,
                    onChanged: (result) {
                      if (result.isEmpty) {
                        bookProvider.clearSearch();
                      } else {
                        bookProvider.searchBooks(result);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Consumer<BookProvider>(
                      builder: (context, provider, child) {
                        final books = _searchController.text.isNotEmpty
                            ? provider.searchResults
                            : provider.books;

                        return books.isNotEmpty
                            ? ListView.builder(
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  final book = books[index];
                                  return ListTile(
                                    leading: Image.asset(
                                      book.coverUrl,
                                      width: 40,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image),
                                    ),
                                    title: Text(
                                      book.title,
                                      style: GoogleFonts.nunito(
                                        color: const Color(0xffffffff),
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      book.author,
                                      style: GoogleFonts.nunito(
                                        color: const Color(0xff03dbfc),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        book.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: book.isFavorite
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                      onPressed: () {
                                        book.isFavorite = !book.isFavorite;
                                      },
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'No books found',
                                  style: GoogleFonts.nunito(
                                    color: const Color(0xffffffff),
                                    fontSize: 20,
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
