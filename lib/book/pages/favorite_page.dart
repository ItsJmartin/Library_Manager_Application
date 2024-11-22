import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management_app/book/book_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    // Filter books to show only favorites
    final favoriteBooks =
        bookProvider.books.where((book) => book.isFavorite).toList();

    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),  
      body: favoriteBooks.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];

                return ListTile(
                  leading: Image.asset(
                    book.coverUrl,
                    width: 40,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) =>
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
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Toggle favorite status when clicked
                      book.isFavorite = !book.isFavorite;
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No favorite books yet!',
                style: GoogleFonts.nunito(
                  color: const Color(0xffffffff),
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
