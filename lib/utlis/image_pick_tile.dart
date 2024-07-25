import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ImagePickTile extends StatelessWidget {
  String title;
  String subtitile;
  VoidCallback onPressed;
  ImagePickTile(
      {required this.title,
        required this.subtitile,
        required this.onPressed,
        super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Image.asset(
        'assets/images/png-clipart-gray-message-icon-computer-icons-document-button-save-copy-miscellaneous-angle-removebg-preview.png',
        scale: 10,
      ),
      title: Text(
        title,
        style:  TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.abhayaLibre().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitile,
        style:  TextStyle(
            color: Colors.grey,             fontFamily: GoogleFonts.abhayaLibre().fontFamily,
        ),
      ),
    );
  }
}
