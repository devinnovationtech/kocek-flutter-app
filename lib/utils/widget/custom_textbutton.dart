import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/extension/capitalize.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

enum KocekCase { uppercase, lowercase, capitalize, original }

class CustomTextButton extends StatelessWidget {
  static CustomTextButton placeholder(
          {String? bottomText,
          void Function()? onTap,
          bool animated = true,
          Color? splashColor,
          EdgeInsetsGeometry? margin,
          Color? color,
          Color? circularColor,
          Color? highlightColor}) =>
      CustomTextButton.rich(
          bottomText: bottomText,
          onTap: onTap,
          backgroundImage: false,
          highlightColor: highlightColor,
          splashColor: splashColor,
          margin: margin,
          color: Colors.white,
          customText: Builder(builder: (context) {
            var my = ThemeShortcut.of(context);

            return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: color ?? my.color.primary.withOpacity(0.1),
                    borderRadius: radiusAll(circular(radius))),
                constraints: const BoxConstraints.expand(),
                child: animated
                    ? LinearProgressIndicator(
                        backgroundColor: color ??
                            Color.lerp(
                                my.color.background, my.color.primary, 0.1),
                        color: color ?? my.color.primary.withOpacity(0.1))
                    : null);
          }));

  static CustomTextButton loading(
          {String? bottomText,
          void Function()? onTap,
          Color? splashColor,
          EdgeInsetsGeometry? margin,
          bool backgroundImage = true,
          BoxBorder? outerBorder,
          Color? color,
          Color? circularColor,
          Color? highlightColor}) =>
      CustomTextButton.rich(
          outerBorder: outerBorder,
          bottomText: bottomText,
          onTap: onTap,
          highlightColor: highlightColor,
          splashColor: splashColor,
          margin: margin,
          color: color,
          backgroundImage: backgroundImage,
          customText: Builder(builder: (context) {
            var my = ThemeShortcut.of(context);

            return Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: circularColor ?? my.color.onBackground));
          }));

  const CustomTextButton(
      {Key? key,
      required this.text,
      this.margin,
      this.onTap,
      this.bottomText,
      this.onBottomTap,
      this.topText,
      this.textStyle,
      this.topTextStyle,
      this.crossAxisAlignment,
      this.splashColor,
      this.color,
      this.backgroundImage = true,
      this.backgroundColor,
      this.border,
      this.outerBorder,
      this.edge = radius,
      this.highlightColor,
      this.height,
      this.icon,
      this.textcase = KocekCase.original,
      this.topTextAlign})
      : customText = null,
        super(key: key);

  const CustomTextButton.rich(
      {Key? key,
      this.backgroundColor,
      this.margin,
      this.highlightColor,
      this.onTap,
      this.onBottomTap,
      this.bottomText,
      this.topText,
      this.topTextStyle,
      this.color,
      this.border,
      this.outerBorder,
      this.customText,
      this.crossAxisAlignment,
      this.splashColor,
      this.edge = radius,
      this.height,
      this.icon,
      this.backgroundImage = true,
      this.textcase = KocekCase.original,
      this.topTextAlign})
      : text = "",
        textStyle = null,
        super(key: key);

  final void Function()? onTap;
  final KocekCase textcase;
  final String? bottomText, topText;
  final String text;
  final TextStyle? textStyle, topTextStyle;
  final TextAlign? topTextAlign;
  final Color? color, backgroundColor;
  final EdgeInsetsGeometry? margin;
  final Widget? customText;
  final CrossAxisAlignment? crossAxisAlignment;
  final Color? splashColor;
  final Color? highlightColor;
  final BoxBorder? border, outerBorder;
  final double edge;
  final double? height;
  final void Function()? onBottomTap;
  final bool backgroundImage;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
          border: outerBorder, color: backgroundColor ?? Colors.transparent),
      child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.stretch,
              children: [
                if (topText != null)
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(topText!,
                          textAlign: topTextAlign ?? TextAlign.left,
                          style: topTextStyle ??
                              my.text.labelSmall?.copyWith(
                                  color: my.color.onBackground.withOpacity(0.5),
                                  fontSize: 11.0))),
                DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                        image: backgroundImage
                            ? DecorationImage(
                                image: const AssetImage(
                                    KocekAsset.jpg_login_background),
                                fit: [
                                  BoxFit.cover,
                                  BoxFit.fitWidth
                                ][Random().nextInt(2)],
                                opacity: 0.05,
                                colorFilter: ColorFilter.mode(
                                    my.color.onBackground.withOpacity(0.05),
                                    BlendMode.color))
                            : null,
                        border: border,
                        borderRadius: BorderRadius.circular(edge)),
                    child: Material(
                        color: color ?? my.color.secondary,
                        borderRadius: BorderRadius.circular(edge),
                        child: InkWell(
                            onTap: onTap,
                            highlightColor: highlightColor ?? transparent,
                            splashColor: splashColor,
                            borderRadius: BorderRadius.circular(edge),
                            child: DefaultTextStyle(
                                style: TextStyle(
                                    color: my.color.onBackground,
                                    fontSize: 16.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: (height != null && height! <= 0)
                                        ? null
                                        : buttonHeight,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customText ??
                                            Text([text.toUpperCase(), text.toLowerCase(), text.toCaps(), text][textcase.index],
                                                style: (textStyle ??
                                                    my.text.labelMedium?.copyWith(fontSize: 16, color: Colors.black))
                                                    ?.copyWith(fontSize: 14.0)),
                                        if (icon != null)
                                          Padding(
                                              padding: const EdgeInsets.only(left: 12.0),
                                              child: icon)
                                      ],
                                    )
                                ))))),
                if (bottomText != null)
                  Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: InkWell(
                          onTap: onBottomTap,
                          child: Text(bottomText!, style: my.text.labelSmall)))
              ])),
    );
  }
}
