import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekHourPicker extends StatefulWidget {
  const KocekHourPicker(
      {Key? key,
      required this.controller,
      this.autoDispose = true,
      this.editable = true,
      this.margin})
      : super(key: key);
  final KocekHourPickerController controller;
  final bool autoDispose, editable;
  final EdgeInsetsGeometry? margin;

  @override
  _KocekHourPickerState createState() => _KocekHourPickerState();
}

class _KocekHourPickerState extends State<KocekHourPicker> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return GestureDetector(
        onTap: widget.editable
            ? () async {
                TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: widget.controller.value ?? TimeOfDay.now());

                if (time != null) widget.controller.value = time;
              }
            : null,
        child: AbsorbPointer(
            child: CustomTextField(
                topText: "Jam",
                topTextStyle: my.text.labelSmall?.copyWith(
                    color: my.color.onBackground.withOpacity(0.5),
                    fontSize: 11.0),
                editable: false,
                margin: widget.margin ?? insetOn(bottom: padding),
                editableColor: widget.editable
                    ? my.color.background
                    : my.color.primary.withOpacity(0.1),
                hintText: KocekParse.formatTime(
                    widget.controller.value ?? TimeOfDay.now(),
                    format: "!hour:!minute"),
                hintStyle: my.text.labelSmall?.copyWith(
                    color: widget.editable
                        ? my.color.onBackground
                        : my.color.onBackground.withOpacity(0.5)),
                border: Border.all(
                    width: 1.5, color: my.color.primary.withOpacity(0.1)),
                icon: DecoratedBox(
                    decoration: BoxDecoration(
                        color: my.color.primary.withOpacity(0.1),
                        borderRadius: radiusOn(
                            topRight: circular(radius),
                            bottomRight: circular(radius))),
                    child: Icon(Icons.watch_later_outlined,
                        color: widget.editable ? my.color.onBackground : my.color.onBackground.withOpacity(0.5))))));
  }
}

class KocekHourPickerController extends ValueNotifier<TimeOfDay?> {
  KocekHourPickerController({TimeOfDay? value}) : super(value);
}
