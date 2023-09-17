import 'package:flutter/material.dart';

class ThemeShortcut {
  final ThemeData theme;
  final TextTheme text;
  final ColorScheme color;
  final BuildContext context;

  ThemeShortcut(
      {required this.theme,
      required this.text,
      required this.color,
      required this.context});

  factory ThemeShortcut.of(BuildContext context) {
    var theme = Theme.of(context);
    var text = theme.textTheme;
    var color = theme.colorScheme;

    return ThemeShortcut(
        theme: theme, text: text, color: color, context: context);
  }
}
