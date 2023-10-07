import 'package:flutter/material.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/bookmark_list_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

class Bookmarks extends StatelessWidget {
  final List<BookData> books;
  bool loggedIn = false;
  Bookmarks({super.key, required this.books});
  final backgroundColor = Color.fromARGB(208, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return BookmarksNotLoggedIn();
    }
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          AppBar(
            title: Text(
              "Currently Reading (${books.length})",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 150.0,
              itemCount: books.length,
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
              itemBuilder: (context, index) {
                return BookmarkListItem(
                  heroTag: index,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/book_profile',
                      arguments: BookProfileArguments(
                          heroTag: index, bookData: books[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookmarksNotLoggedIn extends StatelessWidget {
  const BookmarksNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Log in to view the books you've added to your reading list.",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
