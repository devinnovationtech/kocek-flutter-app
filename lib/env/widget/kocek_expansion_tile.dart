import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';

class KocekExpansionTile extends StatefulWidget {
  const KocekExpansionTile(
      {Key? key,
      this.controller,
      this.autoDispose = false,
      this.icon,
      required this.label,
      this.children = const []})
      : super(key: key);
  final KocekExpansionTileController? controller;
  final bool autoDispose;
  final String label;
  final Widget? icon;
  final List<Widget> children;

  @override
  State<KocekExpansionTile> createState() => _Child();
}

class _Child extends _KocekExpansionTileState {
  @override
  Widget builder(BuildContext context, KocekShortcut my) {
    return Column(children: [
      GestureDetector(
          onTap: onTapped,
          child: Container(
              color: my.color.background,
              alignment: Alignment.centerLeft,
              height: buttonHeight,
              padding: insetAxis(x: padding * 0.5),
              child: Row(children: [
                if (widget.icon != null) widget.icon!,
                const SizedBox(width: padding * 0.5),
                Expanded(
                    child: Text(widget.label,
                        style: my.text.bodySmall?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: my.color.onBackground.withOpacity(0.75)))),
                TweenAnimationBuilder<double>(
                    tween: Tween(end: 3.14 * (controller.value ? 1 : 0)),
                    duration: duration,
                    builder: (_, value, child) =>
                        Transform.rotate(angle: value, child: child),
                    child: Icon(Icons.keyboard_arrow_down_sharp,
                        color: my.color.onBackground))
              ]))),
      if (controller.value)
        Container(
            margin: insetOn(left: (padding + 20.0) * 0.5),
            padding: insetOn(left: (padding + 20.0) * 0.5),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        width: 1,
                        color: my.color.onBackground.withOpacity(0.1)))),
            child: Column(children: widget.children))
    ]);
  }
}

class _KocekExpansionTileState extends State<KocekExpansionTile> {
  Widget builder(BuildContext context, KocekShortcut my) => const Placeholder();

  @override
  Widget build(BuildContext context) =>
      builder(context, KocekShortcut.of(context));

  late KocekExpansionTileController controller =
      widget.controller ?? KocekExpansionTileController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.autoDispose) controller.dispose();
    super.dispose();
  }

  void onTapped() => controller.value = !controller.value;
}

class KocekExpansionTileController extends ValueNotifier<bool> {
  KocekExpansionTileController({bool? value}) : super(value ?? false);
}
