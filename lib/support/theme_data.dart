import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData getTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1C3F37),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 30,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 1,
          primary: const Color(0xFF3a4d34),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
      textTheme: const TextTheme(
        // Text used in tiles
        headline4: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          color: Color(0xFF1C3F37),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF1C3F37),
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF3a4d34).withOpacity(0.1),
        focusColor: Colors.green,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 2,
        indent: 5,
        endIndent: 5,
      ),
    );
  }
}
