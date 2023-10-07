import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/add_activity_bottom_sheet.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:http/http.dart' as http;

import '../feed_masonry_view.dart';
import 'feed_error_view.dart';
import 'feed_loading_view.dart';

class Feed extends StatefulWidget {
  const Feed({
    super.key,
  });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  final contentSpacing = 8.0;

  late Future<List<BookData>> bookFetcher;
  User? currentUser = FirebaseAuth.instance.currentUser;

  int books_displayed = 0;
  final int books_per_query = 40;

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
        'https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&maxResults=${books_per_query}'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final items = jsonData['items'] as List<dynamic>;
      final books = items.map((item) => BookData.fromJson(item)).toList();
      books.shuffle();
      return books;
    } else {
      throw (response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    bookFetcher = fetchRandomBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: AppBar(title: NerdspaceSearchBar()),
      ),
      Expanded(
        child: FutureBuilder<List<BookData>>(
          future: bookFetcher,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.data!;
              if (currentUser != null) {
                return Theme(
                  data: Theme.of(context).copyWith(useMaterial3: true),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        title: Center(
                          child: FittedBox(
                            child: Text(
                              "Welcome back, ${currentUser!.displayName}!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: FeedMasonryView(books: books))
                    ],
                  ),
                );
              }
              return FeedMasonryView(books: books);
            } else if (snapshot.hasError) {
              return FeedErrorView(
                  snapshot: snapshot,
                  onPressed: () {
                    setState(() {
                      bookFetcher = fetchRandomBooks();
                    });
                  });
            } else {
              return FeedLoadingView();
            }
          },
        ),
      ),
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
