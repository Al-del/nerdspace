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

class BookProfileRoute extends StatelessWidget {
  final BookProfileArguments args;
  final imageHeight = 400.0;
  const BookProfileRoute(
      {super.key, this.args = const BookProfileArguments.empty()});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ColorScheme>(
        future: ColorScheme.fromImageProvider(
            provider:
                args.bookData.coverImageProvider ?? PlaceholderImageProvider()),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Hero(
                              tag: args.heroTag,
                              child: DropshadowImage(
                                image: args.bookData.coverImageProvider ??
                                    PlaceholderImageProvider(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          args.bookData.title,
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
                          "By ${args.bookData.author}",
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
                        child: Text(
                          "See reviews:",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: colorScheme.secondary),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      FullRatingDisplayer(),
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
