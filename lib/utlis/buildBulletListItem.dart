import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildBulletListItem(String text) {
  return Row(
    children: [
      Icon(Icons.circle, size: 8, color: HexColor("4D4D4D")),
      const SizedBox(width: 10),
      Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(overflow: TextOverflow.ellipsis,color: HexColor("4D4D4D")),
      ),
    ],
  );
}
