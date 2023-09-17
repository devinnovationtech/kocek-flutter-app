import 'package:flutter/material.dart';
import 'package:kocek_app/utils/extension/capitalize.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekMultiDropdwon extends StatefulWidget {
  const KocekMultiDropdwon(
      {Key? key,
      this.topText,
      this.border,
      this.style,
      this.hint,
      this.topTextStyle,
      this.initialValue,
      this.margin,
      this.color,
      required this.controller,
      required this.values})
      : super(key: key);
  final String? topText;
  final TextStyle? topTextStyle, style;
  final EdgeInsetsGeometry? margin;
  final List<String> values;
  final String? hint;
  final int? initialValue;
  final Color? color;
  final BoxBorder? border;
  final DropdownController controller;

  @override
  State<KocekMultiDropdwon> createState() => _KocekMultiDropdwonState();
}

class _KocekMultiDropdwonState extends State<KocekMultiDropdwon> {
  late List<int> value = widget.controller.value;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() => value = widget.controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widget.topText != null)
            Padding(
                padding: insetOn(bottom: radius),
                child: Text(widget.topText!,
                    style: widget.topTextStyle ??
                        my.text.labelSmall?.copyWith(
                            color: my.color.onBackground.withOpacity(0.5),
                            fontSize: 11.0))),
          Container(
              height: buttonHeight,
              alignment: Alignment.centerLeft,
              padding: insetAll(radius),
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: radiusAll(circular(radius)),
                  border: widget.border ??
                      Border.all(
                          width: 1.5,
                          color: my.color.primary.withOpacity(0.1))),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                    child: DropdownButton<int>(
                        underline: const SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        value: widget.initialValue,
                        style: widget.style ??
                            my.text.labelSmall?.copyWith(
                                fontSize: 12.0, color: my.color.onBackground),
                        onTap: () {},
                        hint: widget.hint != null
                            ? Text(
                                value.isEmpty
                                    ? widget.hint!
                                    : List.generate(value.length, (x) => widget.values[value[x]].toLowerCase().toCaps())
                                        .join(", "),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                            : null,
                        onChanged: (_) {},
                        items: List.generate(
                            widget.values.length,
                            (x) => DropdownMenuItem(
                                value: x,
                                onTap: () {},
                                child: MultiDropdownItem(
                                    value: value.contains(x),
                                    onChanged: (value) => value
                                        ? widget.controller.addValue(x)
                                        : widget.controller.removeValue(x),
                                    label: widget.values[x].toLowerCase().toCaps())))))
              ]))
        ]));
  }
}

class MultiDropdownItem extends StatefulWidget {
  const MultiDropdownItem(
      {Key? key,
      required this.label,
      this.value = false,
      required this.onChanged})
      : super(key: key);
  final String label;
  final bool value;
  final void Function(bool value) onChanged;

  @override
  _MultiDropdownItemState createState() => _MultiDropdownItemState();
}

class _MultiDropdownItemState extends State<MultiDropdownItem> {
  late bool value = widget.value;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return InkWell(
      onTap: () {
        setState(() => value = !value);
        widget.onChanged(value);
      },
      child: Row(children: [
        Checkbox(
            activeColor: my.color.primary,
            value: value,
            tristate: false,
            onChanged: (_) {
              setState(() => value = !value);
              widget.onChanged(value);
            }),
        Expanded(
            child: Text(widget.label,
                style: my.text.labelSmall
                    ?.copyWith(color: my.color.onBackground.withOpacity(0.5))))
      ]),
    );
  }
}

class DropdownController extends ValueNotifier<List<int>> {
  DropdownController({List<int> value = const []}) : super(value);

  List<int> addValue(int index) {
    if (value.contains(index)) {
      return value;
    } else {
      value = List.from(value)..add(index);

      notifyListeners();
      return value;
    }
  }

  List<int> removeValue(int index) {
    if (value.contains(index)) {
      value = List.from(value)..removeWhere((e) => e == index);
      notifyListeners();
      return value;
    } else {
      return value;
    }
  }
}
