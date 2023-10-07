import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:http/http.dart' as http;

Future<Image> fetchImage(String url) async {
  Completer<Image> completer = Completer();
  Image image = Image.network(url);
  image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
    (ImageInfo info, bool _) {
      completer.complete(image);
    },
  ));
  return completer.future;
}

Future<List<BookData>> fetchRandomBooks() async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=40'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final items = jsonData['items'] as List<dynamic>;
    final books = items.map((item) => BookData.fromJson(item)).toList();
    books.shuffle();
    return books;
  } else {
    throw Exception('Failed to fetch books');
  }
}

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  final contentSpacing = 8.0;
  late Future<List<BookData>> bookFetcher;

  @override
  void initState() {
    bookFetcher = fetchRandomBooks();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: NerdspaceSearchBar(),
      ),
      Expanded(
        child: FutureBuilder<List<BookData>>(
          future: bookFetcher,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.data!;
              return MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var heroTag = Random.secure().nextDouble();
                  final bookData = books[index];
                  return BookCardGridItem(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/book_profile',
                        arguments: BookProfileArguments(
                            heroTag: heroTag, bookData: bookData),
                      );
                    },
                    heroTag: heroTag,
                    data: bookData,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text('Error: ${snapshot.error}'),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            bookFetcher = fetchRandomBooks();
                          });
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ]);

    ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
