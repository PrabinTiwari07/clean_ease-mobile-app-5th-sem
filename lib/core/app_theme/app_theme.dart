import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    fontFamily: 'Nunito Regular',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Nunito Bold',
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Nunito Regular',
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Nunito Italic',
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito Regular',
        fontSize: 14,
      ),
    ),
  );
}
