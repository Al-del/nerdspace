import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final bool loggedIn = false;
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return UserPageNotLoggedIn();
    }
    return Placeholder();
  }
}

class UserPageNotLoggedIn extends StatelessWidget {
  const UserPageNotLoggedIn({super.key});

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
                Text("Log in to see your profile.",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
