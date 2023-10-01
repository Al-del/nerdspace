import 'package:flutter/material.dart';

class ImageBgScaffold extends StatelessWidget {
  final ImageProvider image;
  final Widget scaffold;
  const ImageBgScaffold(
      {required this.scaffold, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          child: Image(image: image),
          fit: BoxFit.cover,
        ),
        scaffold,
      ],
    );
  }
}
