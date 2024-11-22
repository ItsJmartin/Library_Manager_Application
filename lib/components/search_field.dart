import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const MySearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.nunito(color: const Color(0xffffffff)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xffd9d9d9)),
        hintText: "Search Book",
        hintStyle: GoogleFonts.nunito(color: const Color(0xffffffff)),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Color(0xff8d8f8d), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Color(0xffffffff), width: 1.5),
        ),
      ),
    );
  }
}
