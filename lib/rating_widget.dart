import 'package:flutter/material.dart';

Widget ratingWidget({
  required int number,
  double size = 48,
  Color starColor = Colors.amber,
  Color textColor = Colors.black,
  double fontSize = 12,
}) {
  return SizedBox(
    height: size,
    width: size,
    child: Stack(
      children: [
        Icon(Icons.star, color: starColor, size: size),
        Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    ),
  );
}
