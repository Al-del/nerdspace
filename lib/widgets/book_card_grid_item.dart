import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'book_rating_bar.dart';
import 'dropshadow_image.dart';
import 'placeholder_image_provider.dart';

class BookData {
  final String title;
  final String author;
  final ImageProvider? coverImageProvider;
  final double rating;
  final String coverUrl;

  BookData({
    this.coverUrl = "COVER_MISSING",
    this.title = "TITLE_MISSING",
    this.author = "AUTHOR_MISSING",
    this.coverImageProvider,
    this.rating = 0.0,
  });

  const BookData.empty(
      {this.title = "",
      this.author = "",
      this.coverImageProvider = const AssetImage('assets/book_placeholder.jpg'),
      this.rating = 0,
      this.coverUrl = ""});

  factory BookData.fromJson(Map<Object?, Object?> json) {
    final volumeInfo = json['volumeInfo'] as Map<Object?, Object?>?;
    if (volumeInfo == null) throw ("bruh");
    final title = volumeInfo['title'] as String;
    final authors = volumeInfo['authors'] as List<dynamic>?;
    final author = authors?.join(', ') ?? 'Unknown author';
    final imageLinks = volumeInfo['imageLinks'];
    final coverUrl = imageLinks == null
        ? null
        : (imageLinks as Map<Object?, Object?>)['thumbnail'] as String? ?? null;
    final rating = (volumeInfo['averageRating'] as num?)?.toDouble() ?? 0.0;
    return BookData(
        coverUrl: coverUrl ?? '',
        title: title,
        author: author,
        coverImageProvider: (coverUrl == null
            ? AssetImage('assets/book_placeholder.jpg')
            : NetworkImage(coverUrl)) as ImageProvider,
        rating: rating);
  }

  Map<String, dynamic> toJson() {
    return {
      'volumeInfo': {
        'title': title,
        'authors': [author],
        'imageLinks': {
          'thumbnail': coverUrl,
        },
      }
    };
  }
}

class BookCardGridItem extends StatelessWidget {
  final BookData data;
  final Object heroTag;
  final void Function() onTap;
  final void Function() onAddPages;
  const BookCardGridItem(
      {super.key,
      required this.data,
      required this.onTap,
      required this.heroTag,
      required this.onAddPages});
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
                      child: Center(
                        heightFactor: 1.0,
                        child: Hero(
                          tag: heroTag,
                          child: DropshadowImage(
                            image: data.coverImageProvider ??
                                PlaceholderImageProvider(),
                          ),
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
                        onPressed: onAddPages,
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
