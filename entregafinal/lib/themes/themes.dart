import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF8F9FA), // Fondo claro neutro
    primary: Color(0xFF007BFF), // Azul vibrante
    onPrimary: Color(0xFFFFFFFF), // Texto blanco sobre azul
    secondary: Color(0xFFE3F2FD), // Azul claro pastel
    onSecondary: Color(0xFF0D47A1), // Texto azul oscuro sobre secundario
    tertiary: Color(0xFFFFEB3B), // Amarillo cálido para destacar
    onSurface: Color(0xFF212121), // Texto gris oscuro en fondo claro
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF212121), fontSize: 18), // Texto principal
    bodyMedium: TextStyle(color: Color(0xFF424242), fontSize: 16), // Texto secundario
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF007BFF), // Azul vibrante
    foregroundColor: Colors.white, // Texto blanco en AppBar
    elevation: 4,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF121212), // Fondo oscuro neutro
    primary: Color(0xFF1E88E5), // Azul vibrante oscuro
    onPrimary: Color(0xFFFFFFFF), // Texto blanco sobre azul
    secondary: Color(0xFF004D40), // Verde azulado
    onSecondary: Color(0xFFA5D6A7), // Texto verde claro sobre secundario
    tertiary: Color(0xFFFFC107), // Amarillo cálido para destacar
    onSurface: Color(0xFFE0E0E0), // Texto gris claro en fondo oscuro
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFE0E0E0), fontSize: 18), // Texto principal
    bodyMedium: TextStyle(color: Color(0xFFBDBDBD), fontSize: 16), // Texto secundario
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E88E5), // Azul vibrante oscuro
    foregroundColor: Colors.white, // Texto blanco en AppBar
    elevation: 4,
  ),
);
