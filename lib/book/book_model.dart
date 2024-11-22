// book model
class Book {
  final String title;
  final String author;
  final String publishedYear;
  final String isbn;
  final String coverUrl;
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.isbn,
    required this.coverUrl,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'isbn': isbn,
      'coverUrl': coverUrl,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      publishedYear: json['publishedYear'],
      isbn: json['isbn'],
      coverUrl: json['coverUrl'],
    );
  }
}
