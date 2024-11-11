import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromRGBO(251, 251, 251, 1),
    primary: Color.fromRGBO(198, 231, 255, 1),
    onPrimary: Color.fromRGBO(11, 52, 77, 1),
    secondary: Color.fromRGBO(212, 246, 255, 1),
    tertiary: Color.fromRGBO(255, 221, 174, 1),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromRGBO(0, 11, 88, 1),
    primary: Color.fromRGBO(15, 70, 104, 1),
    onPrimary: Color.fromRGBO(180, 224, 251, 1),
    secondary: Color.fromRGBO(0, 106, 103, 1),
    tertiary: Color.fromRGBO(255, 244, 183, 1),
  ),
);

