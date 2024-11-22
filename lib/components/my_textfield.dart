import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget myTextField(TextEditingController controller, String hint) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      style: GoogleFonts.nunito(color: Color(0xffffffff)),
      controller: controller,
      decoration: InputDecoration(
        // fillColor: Color(0xffffffff),
        // filled: true,
        labelText: hint,
        labelStyle: GoogleFonts.nunito(color: Colors.grey.shade500),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffffffff)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffffffff)),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    ),
  );
}
