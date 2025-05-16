import 'package:flutter/material.dart';

class AppTheme {
  static const Color _lightPrimaryColor = Color.fromARGB(255, 243, 243, 243);
  static const Color _darkPrimaryColor = Color.fromARGB(255, 30, 30, 30);
  static const Color _lightTextColor = Colors.black;
  static const Color _darkTextColor = Colors.white;
  static const Color _lightAppBarColor = Color.fromARGB(255, 243, 243, 243);
  static const Color _darkAppBarColor = Color.fromARGB(255, 30, 30, 30);
  static const Color _darkCardColor = Color.fromARGB(255, 50, 50, 50);
  static const Color _lightCardColor = Colors.white;
  static const Color _onPrimaryColor = Colors.purple;
  static const String _fontFamily = 'Montserrat';

  static ThemeData _baseTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color scaffoldBackgroundColor,
    required Color textColor,
    required Color appBarColor,
    required Color iconColor,
    required Color cardColor,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: _fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        elevation: 0,
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: TextStyle(color: textColor, fontSize: 20),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textColor.withValues(alpha: 0.87),
        ),
      ),
      cardColor: cardColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: _onPrimaryColor,
        secondary: _onPrimaryColor,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: scaffoldBackgroundColor,
        onSurface: textColor,
      ),
    );
  }

  static ThemeData lightTheme = _baseTheme(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightPrimaryColor,
    textColor: _lightTextColor,
    appBarColor: _lightAppBarColor,
    iconColor: Colors.black,
    cardColor: _lightCardColor,
  );

  static ThemeData darkTheme = _baseTheme(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    scaffoldBackgroundColor: _darkPrimaryColor,
    textColor: _darkTextColor,
    appBarColor: _darkAppBarColor,
    iconColor: Colors.white,
    cardColor: _darkCardColor,
  );
}
