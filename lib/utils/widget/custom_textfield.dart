import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
        this.counter,
        this.controller,
        this.topText,
        this.topTextStyle,
        this.margin,
        this.hintStyle,
        this.border,
        this.icon,
        this.filter,
        this.padding,
        this.style,
        this.inputType,
        this.suffix,
        this.prefix,
        this.prefixIcon,
        this.onChanged,
        this.maxLines,
        this.height,
        this.editable = true,
        this.hintText,
        this.color,
        this.borderRadius,
        this.maxLength,
        this.textAlign,
        this.prefixText,
        this.textAlignVertical,
        this.onFocused,
        this.textCapitalization = TextCapitalization.none,
        this.autofocus = false,
        this.editableColor,
        this.obscure})
      : super(key: key);
  final String? topText;
  final bool editable, autofocus;
  final TextStyle? topTextStyle, style, hintStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final String? hintText, prefixText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? icon;
  final Widget? suffix;
  final double? height;
  final Widget? counter;
  final int? maxLines;
  final bool? obscure;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final Color? color;
  final Color? editableColor;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final List<TextInputFormatter>? filter;
  final TextInputType? inputType;
  final void Function(String)? onChanged;
  final void Function(bool focus, String text)? onFocused;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              topText != null
                  ? Padding(
                  padding: insetOn(bottom: 6),
                  child: Text(topText!,
                      style: topTextStyle ??
                          my.kocekText.label1Regular.copyWith(
                              color: my.kocekColor.neutral900.withOpacity(0.8))))
                  : const SizedBox(),
              Container(
                  constraints: const BoxConstraints(minHeight: buttonHeight),
                  height: maxLines != null && maxLines! < 0
                      ? null
                      : height ?? buttonHeight,
                  alignment: Alignment.center,
                  foregroundDecoration: BoxDecoration(
                      border: border ??
                          Border.all(
                              width: 1.5,
                              color: my.color.primary.withOpacity(0.1)),
                      borderRadius: borderRadius ?? BorderRadius.circular(12.0)),
                  decoration: BoxDecoration(
                      color: color ??
                          (editable == true
                              ? my.color.background
                              : editableColor ??
                              my.color.primary.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Focus(
                      onFocusChange: onFocused != null
                          ? (focus) => onFocused!(focus, controller?.text ?? "")
                          : null,
                      child: TextField(
                          autofocus: autofocus,
                          maxLength: maxLength,
                          textAlign: textAlign ?? TextAlign.start,
                          textAlignVertical:
                          textAlignVertical ?? TextAlignVertical.center,
                          controller: controller,
                          readOnly: !editable,
                          obscuringCharacter: "●",
                          maxLines: maxLines != null && maxLines! < 0
                              ? null
                              : maxLines ?? 1,
                          obscureText: obscure ?? false,
                          keyboardType: inputType,
                          style: style ??
                              (!editable
                                  ? my.kocekText.paragraph2Medium.copyWith(
                                  height: 2,
                                  color: my.color.onBackground
                                      .withOpacity(0.5))
                                  : my.kocekText.paragraph2Medium.copyWith(
                                  height: 2,
                                  color: my.color.onBackground)),
                          textCapitalization: textCapitalization,
                          inputFormatters: filter,
                          onChanged: onChanged == null
                              ? null
                              : (text) => onChanged!(text),
                          decoration: InputDecoration(
                              prefixText: prefixText,
                              counter: counter,
                              counterText: '',
                              hintText: hintText ?? "Belum Diisi",
                              hintStyle: hintStyle?.copyWith(fontSize: 12.0) ??
                                  my.kocekText.paragraph2Regular.copyWith(
                                      color: my.kocekColor.neutral300),
                              contentPadding: padding ?? insetAll(8),
                              isDense: true,
                              suffixIcon: icon,
                              suffix: suffix,
                              prefixIcon: prefixIcon,
                              prefix: prefix,
                              border: InputBorder.none))))
            ]));
  }
}
