import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekReadOnlyText extends StatelessWidget {
  const KocekReadOnlyText(
      {Key? key, required this.content, this.label, this.margin})
      : super(key: key);
  final String? label;
  final EdgeInsetsGeometry? margin;
  final String content;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (label != null)
            Padding(
                padding: insetOn(bottom: radius),
                child: Text(label!,
                    style: my.text.labelMedium?.copyWith(fontSize: 14))),
          Container(
              padding: insetAll(padding * 0.5),
              height: content.isEmpty ? buttonHeight : null,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                      width: 1, color: my.color.onBackground.withOpacity(0.1))),
              child: SelectableText(content,
                  style: my.text.labelSmall?.copyWith(
                      color: my.color.onBackground.withOpacity(0.5),
                      height: 1.35)))
        ]));
  }
}
