import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'book_rating_bar.dart';
import 'dropshadow_image.dart';

class BookData {
  final String title;
  final String author;
  final ImageProvider? cover;
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
  final Object heroTag;
  final void Function() onTap;
  const BookCardGridItem(
      {super.key,
      required this.data,
      required this.onTap,
      required this.heroTag});
  final blurValue = 1.0;
  final contentPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
  final bookPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0);
  final maxImageHeight = 450.0;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
        child: InkWell(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          onTap: onTap,
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
                      child: Hero(
                        tag: heroTag,
                        child: DropshadowImage(
                          image: data.cover ??
                              const AssetImage('assets/book_placeholder.jpg'),
                        ),
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
      ),
    );
  }
}
