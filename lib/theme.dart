import 'package:flutter/material.dart';

final class NerdspaceTheme {
  static final cardBorderRadius = 8.0;
  static final cardBorderWidth = 2.0;
  static final data = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardTheme(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
            side: BorderSide(
              color: Colors.white,
              width: cardBorderWidth,
            ))),
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        brightness: Brightness.dark,
        background: Colors.black,
        onBackground: Colors.white),
    textTheme: const TextTheme(),
  );
}
