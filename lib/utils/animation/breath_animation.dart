import 'dart:async';
import 'package:flutter/material.dart';

class BreathAnimation extends StatefulWidget {
  const BreathAnimation({Key? key, required this.duration, required this.child})
      : super(key: key);
  final Duration duration;
  final Widget child;

  @override
  State<BreathAnimation> createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation> {
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
        tween: Tween(end: play ? 1 : 0.85),
        builder: (_, value, child) {
          return Transform.scale(
              scaleY: value,
              scaleX: value,
              alignment: FractionalOffset.bottomCenter,
              child: child);
        },
        child: widget.child);
  }
}
