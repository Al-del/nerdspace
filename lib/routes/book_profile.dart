import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/book_rating_bar.dart';
import 'package:nerdspace/widgets/dropshadow_image.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';

class BookProfileArguments {
  final Object heroTag;
  BookProfileArguments({required this.heroTag});
}

class BookProfileRoute extends StatelessWidget {
  final Object heroTag;
  final imageHeight = 400.0;
  const BookProfileRoute({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return ImageBgScaffold(
      image: Image(
        image: AssetImage('assets/bookshelf-bg2k.jpg'),
      ),
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size.fromHeight(imageHeight)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Hero(
                          tag: heroTag,
                          child: const DropshadowImage(
                            image: AssetImage('assets/book_placeholder.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "The Holy Bible",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "By Anonymous",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          .copyWith(color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  FullRatingDisplayer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
