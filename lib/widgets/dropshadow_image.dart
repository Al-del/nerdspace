import 'package:flutter/material.dart';

class DropshadowImage extends StatelessWidget {
  final ImageProvider image;
  const DropshadowImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white54, // shadow color
            blurRadius: 10,
          ),
        ],
      ),
      child: Image(
        image: image,
      ),
    );
  }
}
