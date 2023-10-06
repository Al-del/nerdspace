import 'package:flutter/material.dart';
import 'package:nerdspace/widgets/image_bg_scaffold.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ImageBgScaffold(
      image: Image.asset('assets/bookshelf-bg2k.jpg'),
      scaffold: Scaffold(
        backgroundColor: theme.colorScheme.inverseSurface,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                "Hold infinity in the palm of your hand.",
                style: theme.textTheme.headlineLarge!
                    .copyWith(color: theme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ),
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
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.secondary),
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      width: 5.0, color: theme.colorScheme.secondary),
                ),
              ),
            ),
            TextField(
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.secondary),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      width: 5.0, color: theme.colorScheme.secondary),
                ),
              ),
            ),
            TextField(
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.secondary),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      width: 5.0, color: theme.colorScheme.secondary),
                ),
              ),
            ),
            TextField(
              style: theme.textTheme.titleMedium!
                  .copyWith(color: theme.colorScheme.secondary),
              decoration: InputDecoration(
                labelText: "Confirm Password",
                labelStyle: theme.textTheme.titleMedium!
                    .copyWith(color: theme.colorScheme.secondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      width: 5.0, color: theme.colorScheme.secondary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
