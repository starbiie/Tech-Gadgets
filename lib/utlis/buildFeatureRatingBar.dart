

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildFeatureRatingWithRatingBar(String feature, double rating) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        feature,
        style: TextStyle(
            fontSize: 14, color: HexColor("4D4D4D"), fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          const SizedBox(width: 10),
          Text(
            "$rating",
            style: TextStyle(color: HexColor("4D4D4D")),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
