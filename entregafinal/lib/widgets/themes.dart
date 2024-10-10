import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromRGBO(210, 224, 251, 90),
    primary: Color.fromRGBO(254, 249, 217, 100),
    secondary: Color.fromRGBO(222, 229, 212, 100),
    tertiary: Color.fromRGBO(142, 172, 205, 100)
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromRGBO(02, 31, 63, 90),
    primary: Color.fromRGBO(58, 109, 140, 100),
    secondary: Color.fromRGBO(106, 154, 176, 100),
    tertiary: Color.fromRGBO(234, 216, 177, 100)
  ),
);

