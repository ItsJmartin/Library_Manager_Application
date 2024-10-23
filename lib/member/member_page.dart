import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SafeArea(
          child: Center(
        child: Text(
          "Author Page",
          style: GoogleFonts.nunito(
              color: Color(0xffffffff),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
