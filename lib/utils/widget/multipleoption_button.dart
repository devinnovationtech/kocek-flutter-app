import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class MultipleoptionButton extends StatelessWidget {
  const MultipleoptionButton(
      {Key? key,
      this.selected = false,
      required this.text,
      this.openNote = false,
      this.openCamera = false,
      this.onTap,
      this.selectedColor})
      : super(key: key);
  final bool selected;
  final String text;
  final Color? selectedColor;
  final void Function()? onTap;
  final bool openCamera, openNote;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1,
                color: selected == true
                    ? selectedColor ?? my.color.primary
                    : my.color.primary)),
        child: InkMaterial(
            borderRadius: radiusAll(circular(radius)),
            color: selected == true
                ? (selectedColor ?? my.color.primary)
                : my.color.background,
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: my.text.labelMedium?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: selected == true
                            ? my.color.background
                            : my.color.primary)))));
  }
}
