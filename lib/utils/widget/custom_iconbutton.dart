import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekSvgButton extends StatelessWidget {
  const KocekSvgButton(
      {Key? key,
      required this.asset,
      required this.text,
      this.size,
      this.color,
      this.padding,
      this.gap,
      this.borderRadius,
      this.onTap})
      : super(key: key);
  final EdgeInsetsGeometry? padding;
  final String asset;
  final String text;
  final Size? size;
  final double? gap;
  final void Function()? onTap;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Tooltip(
        message: text,
        verticalOffset:
            MediaQuery.of(context).viewInsets.bottom - kToolbarHeight,
        child: InkMaterial(
            color: color ?? transparent,
            borderRadius: borderRadius,
            splashColor: my.color.onBackground,
            onTap: onTap,
            child: Container(
                margin: padding ?? EdgeInsets.zero,
                height: kToolbarHeight,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(asset,
                          width: size?.width ?? 38,
                          height: size?.height ?? 38,
                          color: Colors.white),
                      SizedBox(height: gap ?? 8),
                      Text(text,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: my.text.labelSmall?.copyWith(
                              fontSize: 8.0, fontWeight: FontWeight.bold))
                    ]))));
  }
}
