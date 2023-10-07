import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/book_rating_bar.dart';
import 'package:nerdspace/widgets/dropshadow_image.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';
import 'package:nerdspace/widgets/placeholder_image_provider.dart';

class BookProfileArguments {
  final Object heroTag;
  final BookData bookData;
  BookProfileArguments({required this.bookData, required this.heroTag});
  const BookProfileArguments.empty(
      {this.heroTag = -1, this.bookData = const BookData()});
}

class BookProfileRoute extends StatefulWidget {
  final BookProfileArguments args;

  const BookProfileRoute(
      {super.key, this.args = const BookProfileArguments.empty()});

  @override
  State<BookProfileRoute> createState() => _BookProfileRouteState();
}

class _BookProfileRouteState extends State<BookProfileRoute> {
  final double cardBorderWidth = 3.0;

  final double cardBorderRadius = 8.0;

  final imageHeight = 400.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ColorScheme>(
        future: ColorScheme.fromImageProvider(
            provider: widget.args.bookData.coverImageProvider ??
                PlaceholderImageProvider()),
        builder: (context, snapshot) {
          ColorScheme colorScheme = Theme.of(context).colorScheme;
          if (snapshot.hasData) {
            colorScheme = snapshot.data ?? colorScheme;
            print("yo yo yo!");
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.primary,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: colorScheme.secondaryContainer,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.loose(Size.fromHeight(imageHeight)),
                        child: Center(
                          heightFactor: 1.0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Hero(
                              tag: widget.args.heroTag,
                              child: DropshadowImage(
                                image:
                                    widget.args.bookData.coverImageProvider ??
                                        PlaceholderImageProvider(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.args.bookData.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "By ${widget.args.bookData.author}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      colorScheme.inversePrimary)),
                              child: Text(
                                "Add to Bookmarks",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: colorScheme.secondary),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      colorScheme.inversePrimary)),
                              onPressed: () {},
                              child: Text(
                                "Add to Wishlist",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: colorScheme.secondary),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "See reviews:",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: colorScheme.secondary),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Card(
                        color: colorScheme.tertiaryContainer,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: colorScheme.tertiary,
                                width: cardBorderWidth),
                            borderRadius: BorderRadius.all(
                                Radius.circular(cardBorderRadius))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BookRatingBar(
                                      rating: widget.args.bookData.rating,
                                      foregroundColor: colorScheme.primary,
                                      size: 40.0),
                                  Text(
                                    "(${widget.args.bookData.rating}/5)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: colorScheme.tertiary,
                                        ),
                                  ),
                                ],
                              ),
                              Text(
                                "No reviews yet",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: colorScheme.tertiary,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Check back later",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: colorScheme.tertiary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class FullRatingDisplayer extends StatelessWidget {
  const FullRatingDisplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: List.generate(5, (index) {
            return Row(
              children: [
                BookRatingBar(rating: (5 - index).toDouble()),
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.deepOrange,
                    value: pow(((5 - index) / 5.0), 3).toDouble(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
