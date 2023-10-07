import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nerdspace/firebase_options.dart';
import 'package:nerdspace/routes/book_profile.dart';
import 'package:nerdspace/routes/login_route.dart';
import 'package:nerdspace/routes/register_route.dart';
import 'package:nerdspace/theme.dart';
import 'routes/main_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
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
              args: args ?? const BookProfileArguments.empty(),
            );
          });
        }
      },
      routes: {
        '/': (context) => MainScaffold(),
        '/login': (context) => LoginRoute(),
        '/register': (context) => RegisterRoute(),
      },
    );
  }
}
