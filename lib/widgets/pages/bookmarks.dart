import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nerdspace/nerdfire.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/add_activity_bottom_sheet.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/bookmark_list_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

class Bookmarks extends StatefulWidget {
  Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  final backgroundColor = Color.fromARGB(208, 0, 0, 0);

  late Future<List<BookData>> bookFetcher;

  @override
  void initState() {
    bookFetcher = NerdFire().getUserBookData().catchError((obj, stackTrace) {
      print("Not logged in");
      return <BookData>[];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return BookmarksNotLoggedIn();
    }

    return FutureBuilder(
        future: bookFetcher,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return bookmarkErrorView(snapshot);
          }
          if (!snapshot.hasData) {
            return bookmarkLoadingView();
          }
          var books = snapshot.data;
          for (var book in books!) {
            print(book.title);
          }

          return Container(
            color: backgroundColor,
            child: Column(
              children: [
                AppBar(
                  title: Text(
                    "Currently Reading (${books!.length})",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemExtent: 200.0,
                    itemCount: books.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                    itemBuilder: (context, index) {
                      return BookmarkListItem(
                        bookmarkData: BookmarkData(
                          bookData: books[index],
                          readPages: 1,
                        ),
                        heroTag: index,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/book_profile',
                            arguments: BookProfileArguments(
                                heroTag: index, bookData: books[index]),
                          );
                        },
                        onAddPages: () {
                          print("pressed!");
                          showBottomSheet(
                            context: context,
                            builder: (context) => AddActivityBottomSheet(
                              data: books[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Center bookmarkLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center bookmarkErrorView(AsyncSnapshot<List<BookData>> snapshot) {
    return Center(
      child: Column(
        children: [
          Text('Error: ${snapshot.error}'),
          IconButton(
              onPressed: () {
                setState(() {
                  bookFetcher = NerdFire()
                      .getUserBookData()
                      .catchError((obj, stackTrace) {
                    print("Not logged in");
                    return <BookData>[];
                  });
                });
              },
              icon: Icon(Icons.refresh))
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
