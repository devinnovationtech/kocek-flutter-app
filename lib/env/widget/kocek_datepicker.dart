import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekDatePicker extends StatefulWidget {
  const KocekDatePicker(
      {Key? key,
      required this.controller,
      required this.initialDate,
      required this.firstDate,
      this.autoDispose = true,
      this.editable = true,
      this.lastDate,
      this.topText,
      this.margin})
      : super(key: key);
  final KocekDatePickerController controller;
  final DateTime initialDate, firstDate;
  final DateTime? lastDate;
  final bool autoDispose;
  final EdgeInsetsGeometry? margin;
  final String? topText;
  final bool editable;

  @override
  _KocekDatePickerState createState() => _KocekDatePickerState();
}

class _KocekDatePickerState extends State<KocekDatePicker> {
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
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: widget.controller.value ?? widget.initialDate,
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate ?? DateTime.now());

                if (date != null) widget.controller.value = date;
              }
            : null,
        child: AbsorbPointer(
            child: CustomTextField(
                topText: widget.topText ?? "Hari / Tanggal",
                topTextStyle: my.text.labelSmall?.copyWith(
                    color: my.color.onBackground.withOpacity(0.5),
                    fontSize: 11.0),
                editable: false,
                margin: widget.margin ?? insetOn(bottom: padding),
                editableColor: widget.editable
                    ? my.color.background
                    : my.color.primary.withOpacity(0.1),
                hintText: KocekParse.formatDate(
                    widget.controller.value ?? DateTime.now(),
                    format: (x) => '${x.day} / ${x.date} ${x.month} ${x.year}'),
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
                    child:
                        Icon(Icons.date_range_sharp, color: widget.editable ? my.color.onBackground : my.color.onBackground.withOpacity(0.5))))));
  }
}

class KocekDatePickerController extends ValueNotifier<DateTime?> {
  KocekDatePickerController({DateTime? value}) : super(value);
}
