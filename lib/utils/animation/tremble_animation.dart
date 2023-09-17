import 'dart:async';
import 'package:flutter/material.dart';

class TrembleAnimation extends StatefulWidget {
  const TrembleAnimation(
      {Key? key,
      required this.duration,
      required this.child,
      required this.range})
      : super(key: key);
  final Duration duration;
  final double range;
  final Widget child;

  @override
  State<TrembleAnimation> createState() => _TrembleAnimationState();
}

class _TrembleAnimationState extends State<TrembleAnimation> {
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
    return TweenAnimationBuilder<double>(
        duration: widget.duration,
        tween: Tween(end: play ? -widget.range : widget.range),
        builder: (_, value, child) {
          return Transform.translate(
              offset: Offset(value, value / 2), child: child);
        },
        child: widget.child);
  }
}
