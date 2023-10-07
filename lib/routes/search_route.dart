import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/feed_masonry_view.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:nerdspace/widgets/pages/feed.dart';
import 'package:http/http.dart' as http;
import 'package:nerdspace/widgets/pages/feed_error_view.dart';
import 'package:nerdspace/widgets/pages/feed_loading_view.dart';

class SearchRouteArguments {
  final String q;
  SearchRouteArguments(this.q);
}

class SearchRoute extends StatefulWidget {
  final SearchRouteArguments args;
  const SearchRoute({super.key, required this.args});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  Future<List<BookData>> fetchBooks() async {
    var books_per_query = 40;
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=${widget.args.q}&maxResults=${books_per_query}'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final items = jsonData['items'];
      if (items == null) return [];
      final books = (items as List<dynamic>)
          .map((item) => BookData.fromJson(item))
          .toList();
      return books;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NerdspaceSearchBar(),
      ),
      body: FutureBuilder(
          future: fetchBooks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FeedMasonryView(books: snapshot.data!);
            } else if (snapshot.hasError) {
              return FeedErrorView(
                  snapshot: snapshot,
                  onPressed: () {
                    setState(() {});
                  });
            }
            return FeedLoadingView();
          }),
    );
  }
}
