import 'package:flutter/material.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';

class KocekAppbar extends AppBar {
  KocekAppbar(
      {Key? key,
      this.text = '',
      this.textStyle,
      double elevation = 0.0,
      bool centerTitle = true,
      Widget? leading,
      this.child,
      List<Widget>? actions,
      PreferredSizeWidget? bottom,
      bool? automaticallyImplyLeading,
      Color? backgroundColor})
      : super(
            key: key,
            elevation: elevation,
            centerTitle: centerTitle,
            leading: leading,
            bottom: bottom,
            actions: actions,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: automaticallyImplyLeading ?? true);
  final String text;
  final TextStyle? textStyle;
  final Widget? child;

  @override
  Widget? get flexibleSpace => Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return Opacity(
            opacity: 0.15,
            child: Image(
                image: const AssetImage(KocekAsset.jpg_pattern_background),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
                colorBlendMode: BlendMode.lighten,
                color: my.color.onBackground.withOpacity(0.1)));
      });

  @override
  Widget? get title =>
      child ??
      Builder(builder: (context) {
        var my = ThemeShortcut.of(context);
        return Text(text.toUpperCase(),
            style: (textStyle ??
                    my.text.labelMedium?.copyWith(color: my.color.background))
                ?.copyWith(fontSize: 12.0));
      });
}
