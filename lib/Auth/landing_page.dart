import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management_app/author/author_page.dart';
import 'package:library_management_app/book/book_page.dart';
import 'package:library_management_app/member/member_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16.1),
        decoration: const BoxDecoration(
          color: Color(0XFFfefeff),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(
              "Select Your Catogory",
              style: GoogleFonts.nunito(
                color: const Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookPage(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 220,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffb7ecdd),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              //////////
              child: Stack(children: <Widget>[
                // possitioned
                const Positioned(
                  right: -45,
                  bottom: -30,
                  child: SizedBox(
                    child: Image(
                      image: AssetImage("assets/booklistpng/books.png"),
                      height: 280,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Books",
                      style: GoogleFonts.bodoniModa(
                          color: const Color(0xff000000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Collection of World\nFavorite List",
                      style: GoogleFonts.nunito(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                )
              ]),
            ),
          ),
          const SizedBox(height: 20),
          ///////////
          // Second Card
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthorPage(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 220,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffc3e221),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              //////////
              child: Stack(children: <Widget>[
                // possitioned
                const Positioned(
                  right: -60,
                  bottom: -35,
                  child: SizedBox(
                    child: Image(
                      image: AssetImage("assets/booklistpng/authors.png"),
                      height: 260,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Authors",
                      style: GoogleFonts.bodoniModa(
                          color: const Color(0xff000000),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Explore a diverse range\nof authors from various\ngenres and fields",
                      style: GoogleFonts.nunito(
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                )
              ]),
            ),
          ),
          const SizedBox(height: 20),
          //////////// Thrird Card
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MemberPage(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 220,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff747575),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              //////////
              child: Stack(children: <Widget>[
                // possitioned
                const Positioned(
                  right: -180,
                  bottom: -10,
                  child: SizedBox(
                    child: Image(
                      image: AssetImage("assets/booklistpng/members.png"),
                      height: 240,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Members",
                      style: GoogleFonts.bodoniModa(
                          color: const Color(0xffffffff),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome to our community\nof readers! Each member plays\na vital role in fostering a\nlove for literature,\nlearning, and discovery",
                      style: GoogleFonts.nunito(
                          color: const Color(0xffd6d6d6),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
