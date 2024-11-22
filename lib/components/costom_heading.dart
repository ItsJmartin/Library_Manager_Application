import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHeading extends StatelessWidget {
  final String heading;
  const MyHeading({
    super.key,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
        heading,
        style: GoogleFonts.alata(
          color: const Color(0xffffffff),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
