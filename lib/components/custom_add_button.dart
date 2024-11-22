// floating_action_button.dart
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {

  final VoidCallback onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffffffff), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        backgroundColor: const Color(0xff219e08),
        onPressed: onPressed,
        child: const Icon(
          Icons.add,
          color: Color(0xffffffff),
          size: 35,
        ),
      ),
    );
  }
}

