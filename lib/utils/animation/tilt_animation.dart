import 'dart:async';

import 'package:flutter/material.dart';

class TiltAnimation extends StatefulWidget {
  const TiltAnimation(
      {Key? key,
      required this.duration,
      required this.child,
      required this.delay})
      : super(key: key);
  final Duration duration, delay;
  final Widget child;

  @override
  State<TiltAnimation> createState() => _TiltAnimationState();
}

class _TiltAnimationState extends State<TiltAnimation> {
  bool animate = false;

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(widget.delay, (timer) {
      setState(() {
        animate = timer.tick.isOdd;
      });
    });
    super.initState();
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
        tween: Tween(begin: 0, end: animate ? 0 : 3.14 * 0.1),
        builder: (_, value, child) {
          return Transform.rotate(
              child: child,
              origin: Offset.zero,
              alignment: FractionalOffset.center,
              angle: value);
        },
        child: widget.child);
  }
}
