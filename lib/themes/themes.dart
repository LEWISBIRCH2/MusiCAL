import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      surface: Color.fromARGB(255, 255, 255,
          255), // background color for elevated surface components
      primary: Colors.green.shade300, // for key components
      secondary: Colors.green.shade200), // for less prominent components

  scaffoldBackgroundColor: Colors.white, //background color for scaffold widget
  appBarTheme: AppBarTheme(
      backgroundColor:
          const Color.fromARGB(134, 109, 234, 86), // fill color of app bar
      foregroundColor: Colors.black), // icons and text within app bar
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // for large body text
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