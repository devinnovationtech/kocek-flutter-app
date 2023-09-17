import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kocek_app/utils/extension/dateasstring.dart';

enum TextTickerType { countdown, timer }

class TextTicker extends StatefulWidget {
  const TextTicker({
    Key? key,
    this.style,
    this.textAlign,
    required this.time,
    required this.type,
    required this.builder,
  }) : super(key: key);
  final DateTime time;
  final TextTickerType type;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String Function(String data) builder;

  @override
  _TextTickerState createState() => _TextTickerState();
}

class _TextTickerState extends State<TextTicker> {
  Duration duration = Duration.zero;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => duration = widget.time.difference(DateTime.now()));
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        widget.builder(widget.type == TextTickerType.countdown
            ? duration.asCountdown
            : duration.asTimer),
        style: widget.style,
        textAlign: widget.textAlign);
  }
}
