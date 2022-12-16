import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categorcard extends StatelessWidget {
  const Categorcard({
    super.key,
    required this.categoryText,
    required this.isActive,
  });
  final bool isActive;
  final String categoryText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !isActive
              ? const Color.fromRGBO(221, 229, 249, 1)
              : const Color.fromRGBO(130, 0, 255, 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          categoryText,
          style: GoogleFonts.montserrat(
            color: !isActive ? Colors.grey : Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
