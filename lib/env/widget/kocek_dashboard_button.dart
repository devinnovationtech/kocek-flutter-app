import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/extension/capitalize.dart';
import 'package:kocek_app/utils/static/constant_variable.dart'
    as val;
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekDashboardButton extends StatelessWidget {
  const KocekDashboardButton(
      {Key? key,
      this.margin,
      this.padding,
      this.borderRadius,
      this.color,
      this.border,
      required this.child,
      this.backgroundImage = true,
      this.onTap})
      : super(key: key);
  final EdgeInsetsGeometry? margin, padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? color;
  final VoidCallback? onTap;
  final Widget child;
  final bool backgroundImage;

  static Widget withNumber(
          {VoidCallback? onTap,
          required int number,
          required String title,
          required String subtitle,
          EdgeInsetsGeometry? margin}) =>
      Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return KocekDashboardButton(
            onTap: onTap,
            backgroundImage: false,
            borderRadius: radiusAll(circular(val.radius)),
            padding: insetAll(val.padding),
            border:
                Border.all(width: 1, color: my.color.primary.withOpacity(0.05)),
            margin: margin,
            color: my.color.primary.withOpacity(number.isOdd ? 0.05 : 0.0),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  margin: insetOn(right: val.padding),
                  padding: insetAll(val.padding * 0.5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: my.color.onBackground.withOpacity(0.05)),
                  child: Text(number.toString(), style: my.text.labelMedium)),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(title,
                        style: my.text.labelMedium?.copyWith(
                            color: my.color.onBackground, fontSize: 12.0)),
                    Text(subtitle,
                        style: my.text.labelSmall?.copyWith(
                            color: my.color.onBackground.withOpacity(0.5),
                            fontSize: 11.0))
                  ]))
            ]));
      });

  static Widget colorless(
          {Key? key,
          required String title,
          required DateTime date,
          EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          BorderRadius? borderRadius,
          Color? color,
          BoxBorder? border,
          VoidCallback? onTap}) =>
      Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return KocekDashboardButton(
            backgroundImage: false,
            borderRadius: borderRadius ?? radiusAll(circular(val.radius)),
            padding: padding ?? insetAll(val.padding),
            color: color ?? my.color.primary.withOpacity(0.05),
            margin: margin,
            key: key,
            onTap: onTap,
            border:
                Border.all(width: 1, color: my.color.primary.withOpacity(0.05)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: my.text.labelMedium
                      ?.copyWith(color: my.color.onBackground)),
              Text(
                  KocekParse.formatDate(date,
                      format: (x) =>
                          "${x.date} ${x.month} ${x.year}, Pukul ${x.hour}:${x.minute}"),
                  style: my.text.labelSmall?.copyWith(
                      color: my.color.onBackground.withOpacity(0.5),
                      fontSize: 11.0))
            ]));
      });

  static Widget doubleText(
          {Key? key,
          required String title,
          required String subtitle,
          EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          BorderRadius? borderRadius,
          Color? color,
          BoxBorder? border,
          VoidCallback? onTap}) =>
      Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return KocekDashboardButton(
            backgroundImage: false,
            borderRadius: borderRadius ?? radiusAll(circular(val.radius)),
            padding: padding ?? insetAll(val.padding),
            color: color ?? my.color.primary.withOpacity(0.05),
            margin: margin,
            key: key,
            onTap: onTap,
            border:
                Border.all(width: 1, color: my.color.primary.withOpacity(0.05)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: my.text.labelMedium
                      ?.copyWith(color: my.color.onBackground)),
              Text(subtitle,
                  style: my.text.labelSmall?.copyWith(
                      color: my.color.onBackground.withOpacity(0.5),
                      fontSize: 11.0))
            ]));
      });

  static Widget colorful(
          {Key? key,
          required String title,
          required DateTime date,
          EdgeInsetsGeometry? margin,
          EdgeInsetsGeometry? padding,
          BorderRadius? borderRadius,
          Color? color,
          BoxBorder? border,
          VoidCallback? onTap}) =>
      Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return KocekDashboardButton(
          backgroundImage: true,
          borderRadius: borderRadius,
          margin: margin,
          key: key,
          onTap: onTap,
          padding: padding,
          color: color ?? my.color.primary.withOpacity(0.1),
          border:
              Border.all(width: 1, color: my.color.primary.withOpacity(0.1)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title.toLowerCase().toCaps(),
                style:
                    my.text.labelMedium?.copyWith(color: my.color.background)),
            Text(
                KocekParse.formatDate(date,
                    format: (x) =>
                        "${x.date} ${x.month} ${x.year}, Pukul ${x.hour}:${x.minute}"),
                style: my.text.labelSmall?.copyWith(
                    color: my.color.background.withOpacity(0.5),
                    fontSize: 11.0))
          ]),
        );
      });

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Container(
        margin: margin,
        decoration: const BoxDecoration(),
        foregroundDecoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
            image: backgroundImage
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: const AssetImage(KocekAsset.jpg_login_background),
                    opacity: 0.1,
                    colorFilter: ColorFilter.mode(
                        my.color.onBackground.withOpacity(0.05),
                        BlendMode.lighten))
                : null),
        child: InkMaterial(
            highlightColor: val.transparent,
            splashColor: my.color.onBackground.withOpacity(0.1),
            borderRadius: borderRadius,
            color: color,
            onTap: onTap,
            padding: padding,
            child: child));
  }
}
