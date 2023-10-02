import 'package:flutter/material.dart';

final class NerdspaceTheme {
  static const cardBorderRadius = 8.0;
  static const cardBorderWidth = 2.0;
  static const bookTitleSize = 20.0;
  static const bookSubtitleSize = 16.0;
  static final data = ThemeData(
    fontFamily: 'Roboto',
    canvasColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    cardTheme: CardTheme(
        color: Colors.black38,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
            side: BorderSide(
              color: Colors.white,
              width: cardBorderWidth,
            ))),
    scaffoldBackgroundColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        brightness: Brightness.dark,
        background: Colors.black,
        onBackground: Colors.white,
        secondary: Colors.black),
    textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: bookTitleSize,
        ),
        titleSmall: TextStyle(
          fontSize: bookSubtitleSize,
        )),
  );
}
