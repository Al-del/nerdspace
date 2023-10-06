import 'package:flutter/material.dart';

class DropshadowImage extends StatelessWidget {
  final ImageProvider image;
  static const defaultDropShadow = BoxShadow(
    color: Colors.white54, // shadow color
    blurRadius: 10,
  );
  final BoxShadow dropShadow;
  const DropshadowImage({
    super.key,
    required this.image,
    this.dropShadow = defaultDropShadow,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [dropShadow],
      ),
      child: Image(
        image: image,
      ),
    );
  }
}
