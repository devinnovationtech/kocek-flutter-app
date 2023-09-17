import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

import '../static/constant_variable.dart';

class KocekDropdownValueController extends ValueNotifier<int?> {
  KocekDropdownValueController([this._value]) : super(_value);
  int? _value;

  @override
  int? get value => _value;

  @override
  set value(int? newValue) {
    _value = (newValue == null || newValue < 0) ? null : newValue;
    notifyListeners();
  }

  bool isValid(int length) => value != null && value! >= 0 && value! < length;
}

class KocekDropdown extends StatelessWidget {
  const KocekDropdown(
      {Key? key,
      this.topText,
      this.border,
      this.style,
      this.hint,
      this.topTextStyle,
      this.initialValue,
      this.editable = true,
      this.margin,
      this.color,
      this.onChanged,
      required this.values})
      : super(key: key);
  final String? topText;
  final TextStyle? topTextStyle, style;
  final EdgeInsetsGeometry? margin;
  final List<String> values;
  final String? hint;
  final int? initialValue;
  final void Function(int? value)? onChanged;
  final Color? color;
  final BoxBorder? border;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (topText != null)
            Padding(
                padding: insetOn(bottom: radius),
                child:
                    Text(topText!, style: topTextStyle ?? my.text.labelSmall)),
          Container(
              height: buttonHeight,
              alignment: Alignment.centerLeft,
              padding: insetAll(radius),
              decoration: BoxDecoration(
                  color: color ??
                      (!editable
                          ? my.color.primary.withOpacity(0.1)
                          : my.color.background),
                  borderRadius: radiusAll(circular(radius)),
                  border: border ??
                      Border.all(
                          width: 1.5,
                          color: my.color.primary.withOpacity(0.1))),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: DropdownButton<int>(
                        underline: const SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        value: initialValue,
                        style: style ??
                            my.text.bodyMedium?.copyWith(fontSize: 12.0),
                        hint: hint == null
                            ? null
                            : Text(hint!,
                                style: style ??
                                    my.text.labelSmall?.copyWith(
                                        fontSize: 12.0,
                                        color: editable
                                            ? my.color.onBackground
                                            : my.color.onBackground
                                                .withOpacity(0.5))),
                        onChanged: !editable
                            ? null
                            : (value) {
                                if (onChanged != null) onChanged!(value);
                              },
                        items: List.generate(
                            values.length,
                            (x) => DropdownMenuItem(
                                value: x,
                                onTap: editable ? null : () {},
                                child: Text(values[x],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: style ??
                                        my.text.labelSmall?.copyWith(
                                            fontSize: 12.0,
                                            color: editable
                                                ? my.color.onBackground
                                                : my.color.onBackground
                                                    .withOpacity(0.5)))))))
              ]))
        ]));
  }
}

class KocekStatefulDropdown extends StatefulWidget {
  const KocekStatefulDropdown(
      {Key? key,
      required this.controller,
      required this.values,
      this.editable = true,
      this.hint,
      this.margin,
      this.topTextStyle,
      this.autoDispose = true,
      this.topText})
      : super(key: key);
  final KocekDropdownValueController controller;
  final List<String> values;
  final EdgeInsetsGeometry? margin;
  final String? topText, hint;
  final TextStyle? topTextStyle;
  final bool autoDispose, editable;

  @override
  _KocekStatefulDropdownState createState() => _KocekStatefulDropdownState();
}

class _KocekStatefulDropdownState extends State<KocekStatefulDropdown> {
  late int? value = (widget.controller.value ?? -1) > widget.values.length
      ? null
      : widget.controller.value != null && widget.controller.value! < 0
          ? null
          : widget.controller.value;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() => value = widget.controller.value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    return KocekDropdown(
        editable: widget.editable,
        color: !widget.editable ? my.color.primary.withOpacity(0.1) : null,
        style: my.text.labelSmall?.copyWith(
            fontSize: 12.0,
            color:
                my.color.onBackground.withOpacity(widget.editable ? 1 : 0.5)),
        margin: widget.margin,
        topText: widget.topText,
        topTextStyle: widget.topTextStyle ??
            my.text.labelSmall?.copyWith(
                color: my.color.onBackground.withOpacity(0.5), fontSize: 11.0),
        hint: widget.hint ?? "Belum Dipilih",
        values: widget.values,
        initialValue: value,
        onChanged: (value) {
          if ((value ?? 0) >= widget.values.length) {
            widget.controller.value = null;
          } else {
            widget.controller.value = value;
          }
        });
  }
}
