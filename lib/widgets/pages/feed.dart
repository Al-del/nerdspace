import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';
import 'package:http/http.dart' as http;

class BookDataa {
  final String title;
  final String author;
  final String coverUrl;
  final double rating;
  BookDataa(
      {required this.title,
      required this.author,
      required this.coverUrl,
      required this.rating});
  factory BookDataa.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>;
    final title = volumeInfo['title'] as String;
    final authors = volumeInfo['authors'] as List<dynamic>?;
    final author = authors?.join(', ') ?? 'Unknown author';
    final coverUrl = volumeInfo['imageLinks']?['thumbnail'] as String? ?? '';
    final rating = (volumeInfo['averageRating'] as num?)?.toDouble() ?? 0.0;
    return BookDataa(
        title: title, author: author, coverUrl: coverUrl, rating: rating);
  }
}

var contor = 0;
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

Future<List<BookDataa>> fetchRandomBooks() async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=subject:fiction&maxResults=40'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final items = jsonData['items'] as List<dynamic>;
    final books = items.map((item) => BookDataa.fromJson(item)).toList();
    final cover_book = await (books[contor].coverUrl);
    print(cover_book);
    return books;
  } else {
    throw Exception('Failed to fetch books');
  }
}

class Feed extends StatelessWidget {
  const Feed({super.key});
  final contentSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: NerdspaceSearchBar(),
      ),
      Expanded(
        child: FutureBuilder<List<BookDataa>>(
          future: fetchRandomBooks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.data!;
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookCardGridItem(
                      onTap: () {},
                      heroTag: index,
                      data: BookData(
                          title: book.title,
                          author: book.author,
                          rating: book.rating));
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
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
}
