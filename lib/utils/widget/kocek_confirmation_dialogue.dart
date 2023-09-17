import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/env/widget/kocek_label_text.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekConfirmationDialogue extends StatelessWidget {
  const KocekConfirmationDialogue(
      {Key? key,
      this.color,
      required this.label,
      required this.content,
      required this.onCancelTap,
      required this.onNextTap})
      : super(key: key);
  final String label, content;
  final void Function() onCancelTap, onNextTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    Color color = this.color ?? my.color.onBackground;

    return Container(
        margin: insetAll(padding),
        padding: insetAll(padding),
        decoration: BoxDecoration(
            borderRadius: radiusAll(circular(radius)),
            color: my.color.background),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KocekLabelText(
                  label: label.toUpperCase(),
                  content: content,
                  gap: padding * 0.5,
                  labelStyle:
                      my.text.labelMedium?.copyWith(fontSize: 16, color: color),
                  margin: insetOn(bottom: padding)),
              Row(children: [
                Expanded(
                    child: CustomTextButton(
                        onTap: onCancelTap,
                        highlightColor: transparent,
                        margin: insetOn(right: padding / 2),
                        color: my.color.background,
                        text: "Batal",
                        textStyle:
                            my.text.labelMedium?.copyWith(color: color))),
                Expanded(
                    child: CustomTextButton(
                        text: "Lanjut",
                        onTap: onNextTap,
                        margin: insetOn(left: padding / 2),
                        textStyle: my.text.labelMedium
                            ?.copyWith(color: my.color.background),
                        color: color,
                        highlightColor: transparent,
                        splashColor: my.color.onBackground))
              ])
            ]));
  }
}
