import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'book_rating_bar.dart';
import 'dropshadow_image.dart';

class BookData {
  final String title;
  final String author;
  final Image? cover;
  final double rating;

  BookData({
    this.title = "TITLE_MISSING",
    this.author = "AUTHOR_MISSING",
    this.cover,
    this.rating = 0.0, 
  });
}

class BookCardGridItem extends StatelessWidget {
  final BookData data;

  const BookCardGridItem({super.key, required this.data});

  final blurValue = 1.0;
  final contentPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
  final bookPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0);
  final maxImageHeight = 350.0;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
        child: Card(
          child: Padding(
            padding: contentPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints:
                      BoxConstraints.loose(Size.fromHeight(maxImageHeight)),
                  child: Padding(
                    padding: bookPadding,
                    child: DropshadowImage(
                      image: NetworkImage("https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1500191671l/61663._SY475_.jpg"),
                    ),
                  ),
                ),
                Text(
                  data.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "By ${data.author}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: BookRatingBar(rating: data.rating),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
