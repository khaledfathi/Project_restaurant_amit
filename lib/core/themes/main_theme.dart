import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData apply = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffF9F9F9),
      ),
      scaffoldBackgroundColor: const Color(0xffF9F9F9),
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)));
}
