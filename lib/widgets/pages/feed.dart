import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/nerdspace_searchbar.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});
  final contentSpacing = 8.0;

  Widget itemBuilder(context, index) {
    return BookCardGridItem(
        data: BookData(
      title: "The Holy Bible",
      author: "Anonymous",
      rating: 4.5,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: NerdspaceSearchBar(),
        ),
        Expanded(
          child: MasonryGridView.builder(
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: itemBuilder,
            crossAxisSpacing: contentSpacing,
            mainAxisSpacing: contentSpacing,
          ),
        ),
      ],
    );
  }
}
