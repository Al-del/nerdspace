import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookRatingBar extends StatelessWidget {
  const BookRatingBar({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemCount: 5,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
    );
  }
}
