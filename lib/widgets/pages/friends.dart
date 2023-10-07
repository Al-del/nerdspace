import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  final bool loggedIn = false;
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return FriendsPageNotLoggedIn();
    }
    return Placeholder();
  }
}

class FriendsPageNotLoggedIn extends StatelessWidget {
  const FriendsPageNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Coming soon.....",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
