import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/theme.dart';
import 'routes/main_scaffold.dart';

void main() {
  runApp(NerdspaceApp());
}

class NerdspaceApp extends StatelessWidget {
  const NerdspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: NerdspaceTheme.data,
      onGenerateRoute: (settings) {
        if (settings.name == '/book_profile') {
          return MaterialPageRoute(builder: (context) {
            var args = settings.arguments as BookProfileArguments?;
            return BookProfileRoute(
              heroTag: args == null ? Random.secure() : args.heroTag,
            );
          });
        }
      },
      routes: {
        '/': (context) => MainScaffold(),
      },
    );
  }
}
