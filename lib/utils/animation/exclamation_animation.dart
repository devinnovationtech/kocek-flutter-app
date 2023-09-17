import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kocek_app/utils/paint/exclamation_mark.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class ExclamationAnimation extends StatefulWidget {
  const ExclamationAnimation({Key? key, required this.duration})
      : super(key: key);
  final Duration duration;

  @override
  State<ExclamationAnimation> createState() => _ExclamationAnimationState();
}

class _ExclamationAnimationState extends State<ExclamationAnimation> {
  bool play = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        play = timer.tick.isOdd;
      });
    });
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    Color fill = mixColor(my.color.background, my.color.error, 0.75);
    Color outline = my.color.background;

    return TweenAnimationBuilder<double>(
        tween: Tween(end: play ? 1 : 0),
        duration: widget.duration,
        builder: (_, value, child) {
          return CustomPaint(
              painter: ExclamationMark(
                  firstColor: fill.withOpacity(value),
                  firstOutline: outline.withOpacity(value),
                  secondColor: fill.withOpacity(1 - value),
                  secondOutline: outline.withOpacity(1 - value)));
        });
  }
}
