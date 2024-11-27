import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MyTextfield extends StatelessWidget {

  final String label;
  final TextEditingController? controller;

    // validator fn
  final String? Function(String?)? validator;

  const MyTextfield({super.key,

  required this.label,
  required this.controller,
  required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      style: GoogleFonts.nunito(color: Color(0xffffffff)),
      controller: controller,
      decoration: InputDecoration(
        // fillColor: Color(0xffffffff),
        // filled: true,
        labelText: label,
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
}

