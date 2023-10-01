import 'dart:ui';

import 'package:flutter/material.dart';

class BookCardGridItem extends StatelessWidget {
  const BookCardGridItem({super.key});
  final blurValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
        child: Card(),
      ),
    );
  }
}
