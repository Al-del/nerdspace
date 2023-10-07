import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final bool visibleName;
  final name = "Dummy";
  final image = AssetImage('assets/profile_placeholder.png');
  UserAvatar({super.key, this.visibleName = false});

  @override
  Widget build(BuildContext context) {
    return visibleName
        ? Column(
            children: [
              Expanded(
                child: CircleAvatar(
                  backgroundImage: image,
                  maxRadius: 50.0,
                  minRadius: 0.0,
                ),
              ),
              Text(name),
            ],
          )
        : CircleAvatar(
            backgroundImage: image,
            maxRadius: 50.0,
            minRadius: 0.0,
          );
  }
}
