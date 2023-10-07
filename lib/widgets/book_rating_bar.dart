import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookRatingBar extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double? size;
  const BookRatingBar(
      {super.key,
      required this.rating,
      this.backgroundColor = Colors.grey,
      this.foregroundColor = Colors.orange,
      this.size});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemCount: 5,
      unratedColor: backgroundColor,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: foregroundColor,
        size: size,
      ),
    );
  }
}
