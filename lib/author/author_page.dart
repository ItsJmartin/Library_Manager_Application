import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Author {
  String name;
  String genre;
  String email;
  String picUrl;

  Author(
      {required this.name,
      required this.genre,
      required this.email,
      required this.picUrl});

  Map<String, dynamic> toJson() => {
        "name": name,
        "genere": genre,
        "email": email,
        "picUrl": picUrl,
      };

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      genre: json['genre'],
      email: json['email'],
      picUrl: json['picUrl'],
    );
  }
}

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  AuthorListPageState createState() => AuthorListPageState();
}

class AuthorListPageState extends State<AuthorPage> {
  List<Author> authors = [];
  List<Author> searchResults = [];
  final FocusNode _searchFocusNode = FocusNode();
  final _addFormKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();


   // Save data to local storage
  Future<void> saveData() async {
    final directory = await getApplicationDocumentsDirectory();
    final authorFile = File('${directory.path}/authors.json');
    await authorFile.writeAsString(jsonEncode(authors));
  }

  // Load data from local drive
  Future<void> loadData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final authorFile = File('${directory.path}/authors.json');

      if (await authorFile.exists()) {
        final authorData = await authorFile.readAsString();
        setState(() {
          authors = List<Author>.from(
              jsonDecode(authorData).map((data) => Author.fromJson(data)));
        });
      }
    } catch (e) {
      setState(() {
        authors = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // load when app restart
    loadData();

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchAuthorController.text.isEmpty) {
        setState(() {
          searchResults.clear();
        });
      }
    });
  }

  // author adding function
  void addAuthor(String name, String genre, String email, String picUrl) {
    setState(() {
      authors.add(Author(
        name: name,
        genre: genre,
        email: email,
        picUrl: picUrl,
      ));
    });
    saveData();
  }

  void _showAddAuthorDialog(BuildContext context) {
    final nameController = TextEditingController();
    final genreController = TextEditingController();
    final emailController = TextEditingController();
    final picUrlCntroller = TextEditingController();

    // popup
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff000000),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: Color(0xffffffff),
                  width: 1,
                )),
            title: Center(
                child: Text(
              "Add Author",
              style: GoogleFonts.nunito(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            content: SingleChildScrollView(
              child: Form(
                key: _addFormKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.name,
                          style: GoogleFonts.nunito(
                              color: const Color(0xffffffff)),
                          controller: nameController,
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'Name cannot be empty';
                            }

                            // Check if the name contains only alphabets and spaces
                            final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                            if (!nameRegExp.hasMatch(name)) {
                              return 'Name can only contain alphabets, spaces, or hyphens';
                            }

                            // Check if the name is too short
                            if (name.length < 2) {
                              return 'Name must be at least 2 characters long';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: GoogleFonts.nunito(
                                  color: const Color(0xffe6e3e4)))),
                      TextFormField(
                          keyboardType: TextInputType.name,
                          style: GoogleFonts.nunito(
                              color: const Color(0xffffffff)),
                          controller: genreController,
                          validator: (genere) {
                            if (genere == null || genere.isEmpty) {
                              return 'Name cannot be empty';
                            }

                            // Check if the name contains only alphabets and spaces
                            final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                            if (!nameRegExp.hasMatch(genere)) {
                              return 'Name can only contain alphabets, spaces, or hyphens';
                            }

                            // Check if the name is too short
                            if (genere.length < 4) {
                              return 'Name should be more than 4';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Genre",
                              labelStyle: GoogleFonts.nunito(
                                  color: const Color(0xffe6e3e4)))),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.nunito(
                              color: const Color(0xffffffff)),
                          controller: emailController,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Please enter a email';
                            }
                            // Basic check for '@' and '.' in the email
                            if (!email.contains('@') || !email.contains('.')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: GoogleFonts.nunito(
                                  color: const Color(0xffe6e3e4)))),
                      TextFormField(
                          style: GoogleFonts.nunito(
                              color: const Color(0xffffffff)),
                          controller: picUrlCntroller,
                          validator: (url) {
                            if (url == null || url.isEmpty) {
                              return "Please give a valid image path";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Picture Url",
                              labelStyle: GoogleFonts.nunito(
                                  color: const Color(0xffe6e3e4))))
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
                  if (_addFormKey.currentState != null &&
                      _addFormKey.currentState!.validate()) {
                    addAuthor(
                      nameController.text,
                      genreController.text,
                      emailController.text,
                      picUrlCntroller.text,
                    );
                    setState(() {
                      nameController.clear();
                      genreController.clear();
                      emailController.clear();
                      picUrlCntroller.clear();
                    });
                    saveData();
                    Navigator.of(context).pop();
                    // snackbar for details
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text('New Author Added'),
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
        });
  }

  // function for edit Author details
  void editAuthorDetailes(Author author, int index) {
    final nameController = TextEditingController();
    final genreController = TextEditingController();
    final emailController = TextEditingController();
    final picUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xff000000),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: Color(0xffffffff),
                width: 1,
              )),
          title: Center(
              child: Text(
            "Edit Author",
            style: GoogleFonts.nunito(
                color: const Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )),
          content: SingleChildScrollView(
            child: Form(
              key: _editFormKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Name cannot be empty';
                        }

                        // Check if the name contains only alphabets and spaces
                        final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                        if (!nameRegExp.hasMatch(name)) {
                          return 'Name can only contain alphabets, spaces, or hyphens';
                        }

                        // Check if the name is too short
                        if (name.length < 4) {
                          return 'Name must be at least 4 characters long';
                        }
                        return null;
                      },
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: genreController,
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Name cannot be empty';
                        }

                        // Check if the name contains only alphabets and spaces
                        final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s-]+$');
                        if (!nameRegExp.hasMatch(name)) {
                          return 'Name can only contain alphabets, spaces, or hyphens';
                        }

                        // Check if the name is too short
                        if (name.length < 4) {
                          return 'Name must be at least 4 characters long';
                        }
                        return null;
                      },
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Genere",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter a email';
                        }
                        // Basic check for '@' and '.' in the email
                        if (!email.contains('@') || !email.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    ),
                    TextFormField(
                      controller: picUrlController,
                      validator: (url) {
                        if (url == null || url.isEmpty) {
                          return "Please give a valid image path";
                        }
                        return null;
                      },
                      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                      decoration: InputDecoration(
                        labelText: "Picture Url",
                        labelStyle:
                            GoogleFonts.nunito(color: const Color(0xffe6e3e4)),
                      ),
                    )
                  ]),
            ),
          ),
          actions: <Widget>[
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
                    authors[index] = Author(
                      name: nameController.text,
                      genre: genreController.text,
                      email: emailController.text,
                      picUrl: picUrlController.text,
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

  final _searchAuthorController = TextEditingController();

  void searchAuthor(String query) {
    setState(() {
      searchResults = authors
          .where((author) =>
              author.name.toLowerCase() == query.toLowerCase() ||
              author.genre.toLowerCase().contains(query.toLowerCase()))
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: Color(0xffffffff),
                width: 1,
              )),
          title: Text(
            'Delete',
            style: GoogleFonts.nunito(color: const Color(0xffffffff)),
          ),
          content: Text(
            'Are you sure want to delete this Author?',
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
          ],
        );
      },
    );
  } 
  
//////////////////////////////////////////////////Ui//////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/authorbackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: <Widget>[
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
          // second Stack
          Padding(
            padding: const EdgeInsets.fromLTRB(16.1, 35, 16.1, 16.1),
            child: Column(children: <Widget>[
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
                  // Page title
                  'World of Artists',
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
                controller: _searchAuthorController,
                focusNode: _searchFocusNode, // Track focus state
                onChanged: (value) {
                  searchAuthor(value); // Call searchBook on typing
                },
                style: GoogleFonts.nunito(color: const Color(0xffffffff)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xffd9d9d9),
                    ),
                    hintText: "Search Author",
                    hintStyle:
                        GoogleFonts.nunito(color: const Color(0xffffffff)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color(0xff8d8f8d),
                          width: 1,
                        )),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                          width: 1.5,
                        ))),
              ),

              SizedBox(height: 15), // gap between textField and list of Author

              // if the text field focused the search result shown full screen
              Expanded(
                  child: (_searchAuthorController.text.isNotEmpty ||
                          _searchFocusNode.hasFocus)
                      ? searchResults.isNotEmpty
                          ? ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final author = searchResults[index];
                                return ListTile(
                                  leading: Image.network(
                                    author.picUrl,
                                    width: 50,
                                    height: 80,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                  title: Text(
                                    author.name,
                                    style: GoogleFonts.nunito(
                                      color: const Color(0xffffffff),
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Genre: ${author.genre}',
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
                                'No Authors found',
                                style: GoogleFonts.nunito(
                                  color: const Color(0xffffffff),
                                  fontSize: 16,
                                ),
                              ),
                            )
                      : // If search is not active, show all added books
                      ListView.builder(
                          itemCount: authors.length +
                              1, // Add one extra item for the row
                          itemBuilder: (context, index) {
                            if (index == authors.length) {
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
                                      "Add More Authors To Vault",
                                      style: GoogleFonts.nunito(
                                          color: const Color(0xff8b8c8b),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              final author = authors[index];
                              return ListTile(
                                leading: Image.network(
                                  author.picUrl,
                                  width: 40,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                                title: Text(
                                  author.name,
                                  style: GoogleFonts.nunito(
                                    color: const Color(0xffffffff),
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  author.email,
                                  style: GoogleFonts.nunito(
                                    color: const Color(0xff03dbfc),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        editAuthorDetailes(author, index);
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
                                            authors.removeAt(index);
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
              SizedBox(height: 15)
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
                  _showAddAuthorDialog(context); // Show the Add author dialog
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
