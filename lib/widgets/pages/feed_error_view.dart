import 'package:flutter/material.dart';

class FeedErrorView extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final void Function() onPressed;
  const FeedErrorView(
      {super.key, required this.snapshot, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Error: ${snapshot.error}'),
          IconButton(onPressed: onPressed, icon: Icon(Icons.refresh))
        ],
      ),
    );
    ;
  }
}
