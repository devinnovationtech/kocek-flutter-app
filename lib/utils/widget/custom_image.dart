import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

import '../static/constant_variable.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {Key? key,
      this.source,
      this.onError,
      this.errorPadding,
      this.errorColor,
      this.fit})
      : super(key: key);
  final String? source;
  final Color? errorColor;
  final EdgeInsetsGeometry? errorPadding;
  final BoxFit? fit;
  final Widget? onError;

  static Widget error({EdgeInsetsGeometry? errorPadding, Color? errorColor}) =>
      Builder(builder: (context) {
        return Center(
            child: Padding(
                padding: errorPadding ?? insetAll(radius),
                child: SvgPicture.asset("assets/kocek_logo.svg",
                    color: errorColor ??
                        ThemeShortcut.of(context).color.onBackground)));
      });

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    String source = this.source ?? 'assets/poto.png';

    if (source.startsWith("http")) {
      return Image.network(source,
          fit: fit,
          errorBuilder: onError != null
              ? (_, __, ___) => onError!
              : (_, __, ___) =>
                  error(errorColor: errorColor, errorPadding: errorPadding));
    } else if (source.startsWith("data:")) {
      return Image.memory(base64Decode(source.split(',').last),
          fit: fit,
          errorBuilder: onError != null
              ? (_, __, ___) => onError!
              : (_, __, ___) =>
                  error(errorColor: errorColor, errorPadding: errorPadding));
    } else if (source.startsWith("/")) {
      return Image.file(File(source),
          fit: fit,
          errorBuilder: onError != null
              ? (_, __, ___) => onError!
              : (_, __, ___) =>
                  error(errorColor: errorColor, errorPadding: errorPadding));
    } else if (source.startsWith("assets")) {
      return Padding(
          padding:
              source == 'assets/poto.png' ? insetAll(padding) : EdgeInsets.zero,
          child: Image.asset(source,
              fit: fit,
              color: source == 'assets/poto.png' ? my.color.primary : null,
              errorBuilder: onError != null
                  ? (_, __, ___) => onError!
                  : (_, __, ___) => error(
                      errorColor: errorColor, errorPadding: errorPadding)));
    } else {
      return Image.network(KocekApi.baseURL.replaceAll("api", source),
          fit: fit,
          errorBuilder: onError != null
              ? (_, __, ___) => onError!
              : (_, __, ___) =>
                  error(errorColor: errorColor, errorPadding: errorPadding));
    }
  }
}
