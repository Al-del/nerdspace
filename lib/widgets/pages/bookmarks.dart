import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/bookmark_list_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

class Bookmarks extends StatelessWidget {
  Bookmarks({super.key});
  final backgroundColor = Color.fromARGB(208, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          NerdspaceSearchBar(),
          Expanded(
            child: ListView.builder(
              itemExtent: 150.0,
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
              itemBuilder: (context, index) {
                return BookmarkListItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
