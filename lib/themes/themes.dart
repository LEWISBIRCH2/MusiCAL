import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(
        255, 255, 255, 255), // background color for elevated surface components
    primary: Colors.green.shade300, // for key components
    secondary: Colors.green.shade200,
    tertiary: Color.fromARGB(25, 244, 239, 163),
  ),
  // for less prominent compoents

  scaffoldBackgroundColor: Colors.white, //background color for scaffold widget
  appBarTheme: AppBarTheme(
      backgroundColor:
          const Color.fromARGB(134, 109, 234, 86), // fill color of app bar
      foregroundColor: Colors.black), // icons and text within app bar
  textTheme: const TextTheme(
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 40),
      bodyMedium: TextStyle(fontSize: 20),
      bodySmall: TextStyle(fontSize: 20)
      // for large body text
      ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 65, 65, 65),
    primary: Colors.green.shade700,
    secondary: Colors.green.shade900,
    tertiary: const Color.fromARGB(248, 55, 55, 55),
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(248, 55, 55, 55),
      foregroundColor: const Color.fromARGB(255, 247, 247, 247)),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 40),
    bodyMedium: TextStyle(fontSize: 20),
    bodySmall: TextStyle(fontSize: 20),
  ),
);
