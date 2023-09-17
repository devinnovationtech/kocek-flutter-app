import 'package:flutter/material.dart';

class KocekTypography {
  static TextTheme createTextTheme(String fontFamily, Color color) {
    return TextTheme(
      displayLarge: TextStyle(
        debugLabel: 'appTextTheme displayLarge',
        color: color,
        fontSize: 112,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        debugLabel: 'appTextTheme displayMedium',
        color: color,
        fontSize: 56,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -1.5,
      ),
      displaySmall: TextStyle(
        debugLabel: 'appTextTheme displaySmall',
        color: color,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -1.5,
      ),
      headlineLarge: TextStyle(
        debugLabel: 'appTextTheme headlineLarge',
        color: color,
        fontSize: 40,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        debugLabel: 'appTextTheme headlineMedium',
        color: color,
        fontSize: 34,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
      ),
      headlineSmall: TextStyle(
        debugLabel: 'appTextTheme headlineSmall',
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.25,
      ),
      titleLarge: TextStyle(
        debugLabel: 'appTextTheme titleLarge',
        color: color,
        fontSize: 21,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        debugLabel: 'appTextTheme titleMedium',
        color: color,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        debugLabel: 'appTextTheme titleSmall',
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        debugLabel: 'appTextTheme bodyLarge',
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.25,
      ),
      bodyMedium: TextStyle(
        debugLabel: 'appTextTheme bodyMedium',
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.15,
      ),
      bodySmall: TextStyle(
        debugLabel: 'appTextTheme bodySmall',
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        debugLabel: 'appTextTheme labelLarge',
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.25,
      ),
      labelMedium: TextStyle(
        debugLabel: 'appTextTheme labelMedium',
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        debugLabel: 'appTextTheme labelSmall',
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 1.5,
      ),
    );
  }
}