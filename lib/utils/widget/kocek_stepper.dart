import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';

class KocekStepWrapper extends StatefulWidget {
  const KocekStepWrapper(
      {Key? key,
      required this.children,
      this.index = 0,
      this.itemWidth = 200.0})
      : super(key: key);
  final List<KocekStepperModel> children;
  final int index;
  final double itemWidth;

  @override
  State<KocekStepWrapper> createState() => _KocekStepWrapperState();
}

class _KocekStepWrapperState extends State<KocekStepWrapper> {
  ScrollController stepper = ScrollController();
  PageController pager = PageController();
  bool onStepper = true;

  void onPagerScroll(double screenWidth) {
    stepper.jumpTo(widget.itemWidth * (pager.offset / screenWidth));
  }

  void onStepperScroll(double screenWidth) {
    pager.jumpTo(screenWidth * (stepper.offset / widget.itemWidth));
  }

  @override
  void dispose() {
    pager.dispose();
    stepper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Column(mainAxisSize: MainAxisSize.max, children: [
      // Stepper
      Container(
          padding: insetAxis(y: padding),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 3,
                      color: my.color.onBackground.withOpacity(0.1)))),
          child: NotificationListener(
              onNotification: (value) {
                if (onStepper) {
                  if (value is UserScrollNotification &&
                      value.direction == ScrollDirection.idle) {
                    Future.value(value.metrics.extentBefore ~/ widget.itemWidth)
                        .then((value) => stepper.animateTo(
                            widget.itemWidth * value,
                            duration: duration * 0.25,
                            curve: Curves.easeOut));
                  } else {
                    onStepperScroll(my.query.size.width);
                  }
                }
                return false;
              },
              child: GestureDetector(
                  onPanDown: (_) {
                    if (!onStepper) setState(() => onStepper = true);
                  },
                  child: SingleChildScrollView(
                      controller: stepper,
                      padding: insetAxis(x: padding),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        for (var i = 0; i < 4; i++)
                          _KocekStepper(
                              width: widget.itemWidth,
                              index: i + 1,
                              gap: insetOn(
                                  left: padding * 0.5,
                                  right: i == widget.children.length - 1
                                      ? 0
                                      : padding * 0.5),
                              onTap: () {
                                setState(() => onStepper = false);
                                Curve curve = Curves.easeIn;
                                stepper.animateTo(i * widget.itemWidth,
                                    duration: duration, curve: curve);
                                pager.animateToPage(i,
                                    duration: duration, curve: curve);
                              },
                              label: widget.children[i].label,
                              done: widget.children[i].done)
                      ]))))),
      Expanded(
          child: GestureDetector(
              onPanDown: (_) {
                if (onStepper) setState(() => onStepper = false);
              },
              child: PageView.builder(
                  controller: pager
                    ..addListener(() {
                      if (!onStepper) onPagerScroll(my.query.size.width);
                    }),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.children.length,
                  itemBuilder: (_, index) => widget.children[index].child)))
    ]);
  }
}

class KocekStepperModel {
  final Widget child;
  final String label;
  final bool? done;

  KocekStepperModel({required this.child, required this.label, this.done});
}

class _KocekStepper extends StatelessWidget {
  const _KocekStepper(
      {Key? key,
      this.onTap,
      this.done,
      required this.index,
      required this.label,
      this.gap,
      this.width = 200.0})
      : super(key: key);
  final int index;
  final String label;
  final bool? done;
  final double width;
  final EdgeInsetsGeometry? gap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return InkMaterial(
        onTap: onTap,
        splashColor: transparent,
        child: SizedBox(
            width: width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1,
                            color: done == null
                                ? my.color.onBackground.withOpacity(0.1)
                                : my.color.primary)),
                    padding: insetAll(padding * 0.1),
                    child: Container(
                        padding: insetAll(padding * 0.25),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: done == null
                                ? my.color.onBackground.withOpacity(0.1)
                                : my.color.primary),
                        child: Text('$index',
                            style: my.text.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: done == null
                                    ? my.color.onBackground.withOpacity(0.25)
                                    : my.color.background)))),
                Expanded(
                    child: Container(
                        padding: gap,
                        child: ColoredBox(
                            color: done == true
                                ? my.color.primary
                                : my.color.onBackground.withOpacity(0.1)),
                        height: 3))
              ]),
              Text(label,
                  style: my.text.labelMedium?.copyWith(
                      fontSize: 14,
                      color: done == null
                          ? my.color.onBackground.withOpacity(0.25)
                          : my.color.onBackground)),
              Text(done == true ? "Selesai" : "Berjalan",
                  style: my.text.labelSmall?.copyWith(
                      color: my.color.onBackground
                          .withOpacity(done == null ? 0.25 : 0.5)))
            ])));
  }
}
