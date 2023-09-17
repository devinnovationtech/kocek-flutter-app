import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kocek_app/utils/animation/bouncing_animation.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekLoading extends StatelessWidget {
  const KocekLoading(
      {Key? key,
      this.size,
      required this.duration,
      this.color,
      this.thickness = 3.0,
      this.backgroundColor})
      : super(key: key);
  final Duration duration;
  final double thickness;
  final Size? size;
  final Color? color, backgroundColor;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ColoredBox(
            color: backgroundColor ?? Colors.transparent,
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                    width: size?.width ?? 100,
                    height: size?.height ?? 100,
                    child: CircularProgressIndicator(
                        strokeWidth: thickness,
                        color: color ?? my.color.primary)),
                BouncingAnimation(
                    duration: duration,
                    child: SvgPicture.asset("assets/kocek_logo.svg",
                        width: size?.width == null ? 50 : size!.width / 2,
                        color: color ?? my.color.primary))
              ]),
              const SizedBox(height: 10),
              Text("Sedang Memuat",
                  style: my.text.labelSmall
                      ?.copyWith(color: color ?? my.color.primary))
            ]))));
  }
}
