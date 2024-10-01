import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
}

class AppThemes {
  static const EdgeInsets cardPadding = EdgeInsets.symmetric(horizontal: 16);
  static const double cardElevation = 2.0;

  static final CardTheme cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: cardElevation,
  );
}
