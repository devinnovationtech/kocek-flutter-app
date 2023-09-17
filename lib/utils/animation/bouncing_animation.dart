import 'dart:async';

import 'package:flutter/material.dart';

class BouncingAnimation extends StatefulWidget {
  const BouncingAnimation(
      {Key? key, required this.duration, required this.child, this.range = 0.5})
      : super(key: key);
  final Duration duration;
  final double range;
  final Widget child;

  @override
  State<BouncingAnimation> createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation> {
  bool animate = false;

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(widget.duration, (timer) {
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
        tween: Tween(begin: 0, end: animate ? -widget.range : widget.range),
        builder: (_, translation, child) {
          return FractionalTranslation(
              translation: Offset(0, translation), child: child);
        },
        child: TweenAnimationBuilder<double>(
            duration: widget.duration,
            tween: Tween(begin: 1, end: animate ? 1 : 0.75),
            builder: (_, scaling, child) {
              return Transform.scale(
                child: child,
                scaleY: scaling,
              );
            },
            child: widget.child));
  }
}
