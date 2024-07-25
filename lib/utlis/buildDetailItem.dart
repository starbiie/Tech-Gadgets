import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildDetailItem(String title, String detail) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
            color: HexColor("4D4D4D"), fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 10),
      Text(
        detail,
        style: TextStyle(color: HexColor("4D4D4D")),
      ),
    ],
  );
}
