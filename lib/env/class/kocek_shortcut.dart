import 'package:flutter/material.dart';
import 'package:kocek_app/env/themes/colors/kocek_color.dart';
import 'package:kocek_app/env/themes/text/kocek_text_theme.dart';
import 'package:kocek_app/env/themes/text/new_kocek_typography.dart';

class KocekShortcut {
  final ThemeData theme;
  final TextTheme text;
  final ColorScheme color;
  final MediaQueryData query;
  final KocekColor kocekColor;
  final KocekTextTheme kocekText;

  KocekShortcut(
      {required this.theme,
      required this.text,
      required this.color,
      required this.kocekColor,
      required this.kocekText,
      required this.query});

  factory KocekShortcut.of(BuildContext context) {
    var theme = Theme.of(context);
    var text = theme.textTheme;
    var kocekColor = KocekColor.fromKocekColorScheme();
    var color = theme.colorScheme;
    var kocekText = KocekTypography.createTextTheme(
        'PlusJakartaSans', const Color(0xFF202020));
    var query = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return KocekShortcut(
        theme: theme,
        text: text,
        color: color,
        kocekColor: kocekColor,
        kocekText: kocekText,
        query: query);
  }
}
