import 'package:flutter/material.dart';
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
      routes: {
        '/': (context) => MainScaffold(),
      },
    );
  }
}
