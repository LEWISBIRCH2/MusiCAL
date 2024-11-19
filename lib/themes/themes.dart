import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      surface: Color.fromARGB(255, 255, 255, 255),
      primary: Colors.green.shade300,
      secondary: Colors.green.shade200),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(134, 109, 234, 86),
      foregroundColor: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      surface: Color.fromARGB(255, 36, 36, 36),
      primary: Colors.green.shade700,
      secondary: Colors.green.shade900),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(249, 142, 139, 142),
      foregroundColor: const Color.fromARGB(255, 247, 247, 247)),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 240, 239, 239)),
  ),
);
