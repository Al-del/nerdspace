import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/dropshadow_image.dart';

class BookmarkListItem extends StatelessWidget {
  BookmarkListItem({super.key, required this.onTap, required this.heroTag});
  final textColor = Colors.black;
  final cardColor = Color.fromARGB(210, 27, 17, 41);
  final shadowColor = Colors.black;
  final progressColor = Colors.white;
  final Object heroTag;
  final void Function() onTap;
  final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      side: BorderSide(
        color: Colors.purple,
        width: 2.0,
      ));
  final cardElevation = 20.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shadowColor: shadowColor,
      elevation: cardElevation,
      shape: cardShape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.purple,
        highlightColor: Colors.purple,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Hero(
                  tag: heroTag,
                  child: DropshadowImage(
                    image: AssetImage('assets/book_placeholder.jpg'),
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
                      Text("The Holy Bible",
                          style: Theme.of(context).textTheme.titleMedium!
                          //.copyWith(color: textColor),
                          ),
                      Text("By Anonymous",
                          style: Theme.of(context).textTheme.titleSmall!
                          //.copyWith(color: textColor),
                          ),
                      Text("335/700 - chapter 1"),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.5,
                              color: progressColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
    );
  }
}
