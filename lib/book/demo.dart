import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Book {
  String title;
  String author;
  String publishedYear;
  String isbn;
  String coverUrl;

  Book({
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.isbn,
    required this.coverUrl,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'publicationYear': publishedYear,
        'isbn': isbn,
        'coverUrl': coverUrl
      };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      publishedYear: json['publicationYear'],
      isbn: json['isbn'],
      coverUrl: json['coverUrl'],
    );
  }
}

class FullBook extends StatefulWidget {
  const FullBook({super.key});

  @override
  BookListPageState createState() => BookListPageState();
}

class BookListPageState extends State<FullBook> {
  List<Book> books = [];
  List<Book> searchResults = [];
  final FocusNode _searchFocusNode =
      FocusNode(); // To track the focus of the search field
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  // Save data to local storage
  Future<void> saveData() async {
    final directory = await getApplicationDocumentsDirectory();
    final bookFile = File('${directory.path}/books.json');
    await bookFile.writeAsString(jsonEncode(books));
  }

  // Load data from a local file
  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final bookFile = File('${directory.path}/books.json');

      if (await bookFile.exists()) {
        final bookData = await bookFile.readAsString();
        setState(() {
          books = List<Book>.from(
              jsonDecode(bookData).map((data) => Book.fromJson(data)));
        });
      }
    } catch (e) {
      setState(() {
        books = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load data when the app starts
    loadData();

    // Add a listener to the focus node to reset search results when search is unfocused
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchBookController.text.isEmpty) {
        setState(() {
          searchResults.clear();
        });
      }
    });
  }

// book adding function
  void addBook(String title, String author, String publishedYear, String isbn,
      String coverUrl) {
    setState(() {
      books.add(Book(
        title: title,
        author: author,
        publishedYear: publishedYear,
        isbn: isbn,
        coverUrl: coverUrl,
      ));
    });
    saveData(); // Save data after adding a book
  }

  // pop Up Window for enter book detailes
  void _showAddBookDialog(BuildContext context) {
    // creating variables for text input
    final titleController = TextEditingController();
    final authorController = TextEditingController();
    final publishedYearController = TextEditingController();
    final isbnController = TextEditingController();
    final coverUrlController = TextEditingController();

    // pop-up
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Color(0xffffffff), width: 2),
          ),
          backgroundColor: const Color(0xff000000),
          title: Center(
              child: Text(
            "Add Book",
            style: GoogleFonts.nunito(
                color: const Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          )),
          content: SingleChildScrollView(
            child: Form(
              key: _addFormKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.name,
                        style:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        controller: titleController,
                        // validator for name validation
                        validator: (title) {
                          if (title == null || title.isEmpty) {
                            return 'Title cannot be empty';
                          }

                          // Check if the name contains only alphabets and spaces
                          final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                          if (!nameRegExp.hasMatch(title)) {
                            return 'Title can only contain alphabets, spaces, or hyphens';
                          }

                          // Check if the name is too short
                          if (title.length < 4) {
                            return 'Title must be at least 2 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Title",
                            labelStyle: GoogleFonts.nunito(
                                color: const Color(0xffe6e3e4)))),

                    TextFormField(
                        keyboardType: TextInputType.name,
                        style:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        controller: authorController,
                        validator: (author) {
                          if (author == null || author.isEmpty) {
                            return 'Author Name cannot be empty';
                          }

                          // Check if the name contains only alphabets and spaces
                          final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                          if (!nameRegExp.hasMatch(author)) {
                            return 'Name can only contain alphabets, spaces, or hyphens';
                          }

                          // Check if the name is too short
                          if (author.length < 2) {
                            return 'Name must be at least 2 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Author",
                            labelStyle: GoogleFonts.nunito(
                                color: const Color(0xffe6e3e4)))),

                    TextFormField(
                        keyboardType: TextInputType.number,
                        style:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        controller: publishedYearController,
                        validator: (pYear) {
                          if (pYear == null || pYear.isEmpty) {
                            return 'Year cannot be empty';
                          }
                          // Check if the input is numeric
                          if (!RegExp(r'^\d{4}$').hasMatch(pYear)) {
                            return 'Year must be a 4-digit number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Published Year",
                            labelStyle: GoogleFonts.nunito(
                                color: const Color(0xffe6e3e4)))),

                    TextFormField(
                        keyboardType: TextInputType.number,
                        style:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        controller: isbnController,
                        validator: (isbn) {
                          if (isbn == null || isbn.isEmpty) {
                            return 'Please enter the ISBN';
                          }
                          if (isbn.length > 14 || isbn.length < 12) {
                            return 'Please enter the valid ISBN';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "ISBN",
                            labelStyle: GoogleFonts.nunito(
                                color: const Color(0xffe6e3e4)))),

                    TextFormField(
                        style:
                            GoogleFonts.nunito(color: const Color(0xffffffff)),
                        controller: coverUrlController,
                        validator: (url) {
                          if (url == null || url.isEmpty) {
                            return 'Please enter image path';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Cover URL",
                            labelStyle: GoogleFonts.nunito(
                                color: const Color(0xffe6e3e4)))),
                    // (same as your code above)
                  ]),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Color(0xfff01633),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // validate form with global key.
                if (_addFormKey.currentState != null &&
                    _addFormKey.currentState!.validate()) {
                  addBook(
                    titleController.text,
                    authorController.text,
                    publishedYearController.text,
                    isbnController.text,
                    coverUrlController.text,
                  );

                  setState(() {
                    titleController.clear();
                    authorController.clear();
                    publishedYearController.clear();
                    isbnController.clear();
                    coverUrlController.clear();
                  });
                  saveData();
                  Navigator.of(context).pop();
                  //snackbar for details
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Book Add Sucessfull'),
                  ));
                }
              },
              icon: const Icon(Icons.add),
              color: const Color(0xff27c70e),
              iconSize: 30,
            ),
            // Cancel and Add buttons
          ],
        );
      },
    );
  }

// Function to edit an existing book
  void editBookDetailes(Book book, int index) {
    // Create controllers that alredy filled with the current book details
    final titleController = TextEditingController(text: book.title);
    final authorController = TextEditingController(text: book.author);
    final publishedYearController =
        TextEditingController(text: book.publishedYear);
    final isbnController = TextEditingController(text: book.isbn);
    final coverUrlController = TextEditingController(text: book.coverUrl);

    // dialog box for editing
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Color(0xffffffff), width: 2),
          ),
          backgroundColor: const Color(0xff000000),
          title: Center(
              child: Text(
            "Edit Book",
            style: GoogleFonts.nunito(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 24),
          )),
          content: SingleChildScrollView(
            child: Form(
              key: _editFormKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (title) {
                        if (title == null || title.isEmpty) {
                          return 'Title cannot be empty';
                        }

                        // Check if the name contains only alphabets and spaces
                        final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                        if (!nameRegExp.hasMatch(title)) {
                          return 'Title can only contain alphabets, spaces, or hyphens';
                        }

                        // Check if the name is too short
                        if (title.length < 4) {
                          return 'Title must be at least 2 characters long';
                        }
                        return null;
                      },
                      controller: titleController,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      validator: (author) {
                        if (author == null || author.isEmpty) {
                          return 'Author Name cannot be empty';
                        }

                        // Check if the name contains only alphabets and spaces
                        final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                        if (!nameRegExp.hasMatch(author)) {
                          return 'Name can only contain alphabets, spaces, or hyphens';
                        }

                        // Check if the name is too short
                        if (author.length < 2) {
                          return 'Name must be at least 2 characters long';
                        }
                        return null;
                      },
                      controller: authorController,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Author",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      validator: (publishedYear) {
                        if (publishedYear == null || publishedYear.isEmpty) {
                          return 'Year cannot be empty';
                        }

                        // Check if the input is numeric
                        if (!RegExp(r'^\d{4}$').hasMatch(publishedYear)) {
                          return 'Year must be a 4-digit number';
                        }
                        return null;
                      },
                      controller: publishedYearController,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Published Year",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      validator: (isbn) {
                        if (isbn == null || isbn.isEmpty) {
                          return 'Please enter the ISBN';
                        }
                        if (isbn.length > 14 || isbn.length < 12) {
                          return 'Please enter the valid ISBN';
                        }
                        return null;
                      },
                      controller: isbnController,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "ISBN",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      validator: (url) {
                        if (url == null || url.isEmpty) {
                          return 'Please enter image path';
                        }
                        return null;
                      },
                      controller: coverUrlController,
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Cover URL",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                  ]),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: GoogleFonts.nunito(color: const Color(0xfff01633)),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                "Save",
                style: GoogleFonts.nunito(color: const Color(0xff45cf1b)),
              ),
              onPressed: () {
                if (_editFormKey.currentState != null &&
                    _editFormKey.currentState!.validate()) {
                  setState(() {
                    // Update the book details with new values from the dialog
                    books[index] = Book(
                      title: titleController.text,
                      author: authorController.text,
                      publishedYear: publishedYearController.text,
                      isbn: isbnController.text,
                      coverUrl: coverUrlController.text,
                    );
                  });
                  saveData();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  final _searchBookController = TextEditingController();

  // Function to search for a book by Title or ISBN
  void searchBook(String query) {
    setState(() {
      searchResults = books
          .where((book) =>
              book.isbn.toLowerCase() == query.toLowerCase() ||
              book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

// delete confirmation
  void _showDeleteConfirmationDialog(BuildContext context, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xff000000),
            title: Text(
              'Delete',
              style: GoogleFonts.nunito(color: const Color(0xffffffff)),
            ),
            content: Text(
              'Are you sure want to delete this book?',
              style: GoogleFonts.nunito(
                  color: const Color(0xffffffff), fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: GoogleFonts.nunito(
                      color: const Color(0xff45cf1b), fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text(
                  'Delete',
                  style: GoogleFonts.nunito(
                      color: const Color(0xfff01633), fontSize: 16),
                ),
                onPressed: () {
                  onConfirm(); // Call the delete function
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ]);
      },
    );
  }

///////////////////////////////////////book ui structure///////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/booksback.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          // first stack
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
          // Second Stack
          Padding(
            padding: const EdgeInsets.fromLTRB(16.1, 35, 16.1, 16.1),
            child: Column(children: <Widget>[
              // Page title
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xffb8bcbc),
                    Color(0xffffffff),
                    Color(0xffb8bcbc),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Text(
                  'World of Books',
                  style: GoogleFonts.alata(
                    color: const Color(0xffffffff),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Search field
              TextFormField(
                controller: _searchBookController,
                focusNode: _searchFocusNode, // Track focus state
                onChanged: (value) {
                  searchBook(value); // Call searchBook on typing
                },
                style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xffd9d9d9),
                    ),
                    hintText: "Search Book",
                    hintStyle:
                        GoogleFonts.nunito(color: const Color(0xffffffff)),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(
                        color: Color(0xff8d8f8d),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                          width: 1.5,
                        ))),
              ),
              const SizedBox(
                  height: 15), // gap between textField and list of books

              // if the text field focused the search result shown full screen
              Expanded(
                  child: (_searchBookController.text.isNotEmpty ||
                          _searchFocusNode.hasFocus)
                      ? searchResults.isNotEmpty
                          ? ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final book = searchResults[index];
                                return ListTile(
                                  leading: Image.asset(
                                    book.coverUrl,
                                    width: 50,
                                    height: 80,
                                    fit: BoxFit.fill,
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
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xffffffff),
                                    ),
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
                            )
                      : // If search is not active, show all added books
                      ListView.builder(
                          itemCount: books.length +
                              1, // Add one extra item for the row
                          itemBuilder: (context, index) {
                            if (index == books.length) {
                              // last item in the listview builder
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0), // Add some padding
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.lock_outline,
                                      color: Color(0xff085e08),
                                      size: 15,
                                    ),
                                    const SizedBox(
                                        width: 10), // Gap between contents
                                    Text(
                                      "Add More Books To Vault",
                                      style: GoogleFonts.nunito(
                                          color: const Color(0xff8b8c8b),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final book = books[index];
                              return ListTile(
                                leading: Image.asset(
                                  book.coverUrl,
                                  width: 40,
                                  height: 80,
                                  fit: BoxFit.cover,
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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        editBookDetailes(book, index);
                                      },
                                      child: Text(
                                        "Edit",
                                        style: GoogleFonts.nunito(
                                            color: const Color(0xffffffff),
                                            fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outlined,
                                        color: Color(0xffffffff),
                                      ),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(context,
                                            () {
                                          setState(() {
                                            books.removeAt(index);
                                          });
                                          saveData(); //save after deletion
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )),
              const SizedBox(height: 15),
            ]),
          ),
          Positioned(
            // positioned widget for positioning button
            right: 20,
            bottom: 20,
            child: SizedBox(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xffffffff), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                backgroundColor: const Color(0xff219e08),
                onPressed: () {
                  _showAddBookDialog(context); // Show the Add Book dialog
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xffffffff),
                  size: 35,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
