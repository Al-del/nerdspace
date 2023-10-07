import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';
import 'package:firebase_database/firebase_database.dart';

import '../nerdfire.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final pass = TextEditingController();
    final email = TextEditingController();
    ThemeData theme = Theme.of(context);
    var mainTextColor = theme.colorScheme.onPrimary;
    return ImageBgScaffold(
      image: Image.asset('assets/bookshelf-bg2k.jpg'),
      scaffold: Scaffold(
        backgroundColor: theme.colorScheme.inverseSurface,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
        ),
        body: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Register to share your favourite books with your friends and to engage your librarian-self.",
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextField(
              controller: usernameController,
              style:
                  theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle:
                    theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 5.0, color: mainTextColor),
                ),
              ),
            ),
            TextField(
              controller: email,
              style:
                  theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle:
                    theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 5.0, color: mainTextColor),
                ),
              ),
            ),
            TextField(
              controller: pass,
              style:
                  theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle:
                    theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 5.0, color: mainTextColor),
                ),
              ),
            ),
            TextField(
              style:
                  theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
              decoration: InputDecoration(
                labelText: "Confirm Password",
                labelStyle:
                    theme.textTheme.titleMedium!.copyWith(color: mainTextColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 5.0, color: mainTextColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  final username = usernameController.text;
                  final password = pass.text;
                  final email_ = email.text;
                  NerdFire()
                      .register(
                          username: username, password: password, email: email_)
                      .then((value) async {
                    await NerdFire().login(email_, password);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }).catchError(
                    (error, stackTrace) {
                      print("caught error");
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    },
                  );
                },
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
