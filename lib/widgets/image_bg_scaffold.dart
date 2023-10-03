import 'package:flutter/material.dart';

class ImageBgScaffold extends StatelessWidget {
  final Widget image;
  final Widget scaffold;
  const ImageBgScaffold(
      {required this.scaffold, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          child: image,
          fit: BoxFit.cover,
        ),
        scaffold,
      ],
    );
  }
}
