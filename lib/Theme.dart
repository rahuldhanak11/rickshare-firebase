// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: Color.fromRGBO(255, 255, 255, 1),
      tertiary: Color.fromRGBO(255, 229, 0, 1),
      secondary: Color.fromRGBO(255, 184, 0, 1),
      primary: Color.fromRGBO(255, 153, 0, 1),
      primaryContainer: Colors.white,
      secondaryContainer: Colors.black,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Color.fromRGBO(19, 19, 19, 1),
      primary: Color.fromRGBO(255, 229, 0, 1),
      secondary: Color.fromRGBO(255, 184, 0, 1),
      tertiary: Color.fromRGBO(255, 153, 0, 1),
      primaryContainer: Colors.black,
      secondaryContainer: Colors.white,
    ));
