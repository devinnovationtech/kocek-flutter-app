import 'package:flutter/material.dart';
import 'package:kocek_app/env/themes/text/kocek_typography.dart';

Future<ThemeData> kocekTheme() async {
  var textTheme = KocekTypography.createTextTheme(
      'PlusJakartaSans', const Color(0xFF202020));

  return ThemeData(
      colorScheme: const ColorScheme.light(
          error: Color.fromARGB(255, 189, 41, 88),
          secondary: Color(0xFF007AFF),
          onSecondary: Color(0xFF202020),
          primary: Color(0xFF11B1E2),
          tertiary: Color(0xFF60D13A),
          background: Color(0xFFFFFFFF),
          onBackground: Color(0xFF202020)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(
                  color: Color(0xFF007AFF),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold))),
      textTheme: textTheme);
}
