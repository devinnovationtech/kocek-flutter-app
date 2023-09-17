import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kocek_app/utils/extension/dateasstring.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekLabelText extends StatelessWidget {
  const KocekLabelText(
      {Key? key,
      this.contentOverflow,
      this.labelOverflow,
      this.labelStyle,
      required this.label,
      this.reverse = false,
      required this.content,
      this.contentStyle,
      this.gap = radius,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.margin})
      : child = null,
        super(key: key);
  const KocekLabelText.rich(
      {Key? key,
      this.labelStyle,
      required this.child,
      this.reverse = false,
      required this.label,
      this.contentStyle,
      this.gap = radius,
      this.labelOverflow,
      this.contentOverflow,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.margin})
      : content = "",
        assert(child != null),
        super(key: key);
  final String label, content;
  final EdgeInsetsGeometry? margin;
  final TextStyle? contentStyle, labelStyle;
  final bool reverse;
  final Widget? child;
  final double gap;
  final TextOverflow? labelOverflow, contentOverflow;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Container(
        padding: margin ?? EdgeInsets.zero,
        child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label,
                  overflow: labelOverflow,
                  style: labelStyle ??
                      (reverse
                          ? my.text.labelSmall?.copyWith(
                              color: my.color.onBackground.withOpacity(0.5))
                          : my.text.labelMedium?.copyWith(fontSize: 14))),
              SizedBox(height: gap),
              DefaultTextStyle(
                  style: contentStyle ??
                      (reverse
                          ? my.text.labelMedium
                              ?.copyWith(fontSize: 14, height: 1.25)
                          : my.text.labelSmall?.copyWith(
                              color: my.color.onBackground.withOpacity(0.5),
                              height: 1.25)) ??
                      TextStyle(color: my.color.onBackground),
                  child: child ?? Text(content, overflow: contentOverflow))
            ]));
  }
}

class KocekLabelTextTicker extends StatefulWidget {
  const KocekLabelTextTicker(
      {Key? key,
      required this.label,
      this.margin,
      this.deadline,
      this.countdown = true})
      : super(key: key);
  final String label;
  final DateTime? deadline;
  final EdgeInsets? margin;
  final bool countdown;

  @override
  _KocekLabelTextTickerState createState() => _KocekLabelTextTickerState();
}

class _KocekLabelTextTickerState extends State<KocekLabelTextTicker> {
  Duration duration = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.deadline != null) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => duration = widget.deadline!.difference(DateTime.now()));
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KocekLabelText(
        label: widget.label,
        margin: widget.margin,
        content: widget.deadline == null
            ? "-"
            : widget.deadline!.asString() +
                '\n' +
                "(${widget.countdown ? duration.asCountdown : duration.asTimer})");
  }
}
