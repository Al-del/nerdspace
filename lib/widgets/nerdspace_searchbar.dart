import 'package:flutter/material.dart';
import 'nerd_space.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getBookInfo(String name) async {
  final url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$name');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final book = data['items'][0]['volumeInfo'];
    final cover =
        book['imageLinks'] != null ? book['imageLinks']['thumbnail'] : null;
    final author = book['authors'] != null ? book['authors'][0] : null;
    final review = book['description'] != null ? book['description'] : null;
    print(review);
    return {'cover': cover, 'author': author, 'review': review};
  } else {
    throw Exception('Failed to load book info');
  }
}

class NerdspaceSearchBar extends StatelessWidget {
  const NerdspaceSearchBar({super.key});
  final borderWidth = 5.0;
  final fieldPadding = 3.0;
  final hint = "Search by Title, Author or ISBN...";

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        // Handle the submitted value here
        getBookInfo(value);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: hint,
        contentPadding: EdgeInsets.all(fieldPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.white,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}
