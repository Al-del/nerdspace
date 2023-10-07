import 'package:flutter/material.dart';

final class NerdspaceTheme {
  static const cardBorderRadius = 8.0;
  static const cardBorderWidth = 2.0;
  static const bookTitleSize = 20.0;
  static const largeTitleSize = 32.0;
  static const bookSubtitleSize = 16.0;
  static final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepOrange,
    brightness: Brightness.dark,
    background: Colors.black,
  );
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
      backgroundColor: Color(0xFF001011),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black87,
    ),
    colorScheme: colorScheme,
    textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: bookTitleSize,
        ),
        titleLarge: TextStyle(
          fontSize: largeTitleSize,
        ),
        titleSmall: TextStyle(
          fontSize: bookSubtitleSize,
        )),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(cardBorderRadius)),
        side: BorderSide(
          color: Colors.white,
          width: cardBorderWidth,
        ),
      ),
    ),
  );
}
