import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/widgets/add_activity_bottom_sheet.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';

class FeedMasonryView extends StatelessWidget {
  const FeedMasonryView({
    super.key,
    required this.books,
  });

  final List<BookData> books;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: books.length,
      itemBuilder: (context, index) {
        var heroTag = Random.secure().nextDouble();
        final bookData = books[index];
        return BookCardGridItem(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/book_profile',
              arguments:
                  BookProfileArguments(heroTag: heroTag, bookData: bookData),
            );
          },
          onAddPages: () {
            var user = FirebaseAuth.instance.currentUser;
            print("here!");
            if (user == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("You're not logged in!"),
                      ElevatedButton(
                        child: Text("Log in here"),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              );
              return;
            }
            showBottomSheet(
              context: context,
              builder: (context) => AddActivityBottomSheet(
                data: bookData,
              ),
            );
          },
          heroTag: heroTag,
          data: bookData,
        );
      },
    );
  }
}
