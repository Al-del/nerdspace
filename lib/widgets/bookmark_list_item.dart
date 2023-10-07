import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/book_card_grid_item.dart';
import 'package:nerdspace/widgets/dropshadow_image.dart';

class BookmarkData {
  final BookData bookData;
  final int readPages;
  final int totalPages = 700;

  BookmarkData({required this.bookData, required this.readPages});
}

class BookmarkListItem extends StatefulWidget {
  final Object heroTag;
  final void Function() onTap;
  final FutureOr<void> Function() onAddPages;
  final BookmarkData bookmarkData;
  BookmarkListItem({
    super.key,
    required this.onTap,
    required this.heroTag,
    required this.onAddPages,
    required this.bookmarkData,
  });

  @override
  State<BookmarkListItem> createState() => _BookmarkListItemState();
}

class _BookmarkListItemState extends State<BookmarkListItem> {
  final textColor = Colors.black;

  final cardColor = Color.fromARGB(210, 27, 17, 41);

  final shadowColor = Colors.black;

  final progressColor = Colors.white;

  final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      side: BorderSide(
        color: Colors.purple,
        width: 2.0,
      ));

  final cardElevation = 20.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        color: cardColor,
        shadowColor: shadowColor,
        elevation: cardElevation,
        shape: cardShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          splashColor: Colors.purple,
          highlightColor: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Hero(
                    tag: widget.heroTag,
                    child: DropshadowImage(
                      image: widget.bookmarkData.bookData.coverImageProvider ??
                          AssetImage('assets/book_placeholder.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            widget.bookmarkData.bookData.title,
                            style: Theme.of(context).textTheme.titleMedium!,
                            //.copyWith(color: textColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "By ${widget.bookmarkData.bookData.author}",
                            style: Theme.of(context).textTheme.titleSmall!,
                            overflow: TextOverflow.ellipsis,
                            //.copyWith(color: textColor),
                          ),
                        ),
                        Text(
                            "${widget.bookmarkData.readPages}/${widget.bookmarkData.totalPages}"),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: widget.bookmarkData.readPages /
                                    widget.bookmarkData.totalPages,
                                color: progressColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await widget.onAddPages();
                                setState(() {});
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
