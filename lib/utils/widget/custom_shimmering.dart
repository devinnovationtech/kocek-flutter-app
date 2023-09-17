import 'package:flutter/material.dart';

class CustomShimmering extends StatelessWidget {
  const CustomShimmering(
      {Key? key,
      this.color,
      this.backgroundColor,
      this.height,
      this.borderRadius})
      : super(key: key);
  final Color? color, backgroundColor;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: LinearProgressIndicator(
            backgroundColor: backgroundColor ??
                Color.lerp(theme.colorScheme.background,
                    theme.colorScheme.primary, 0.1)!,
            color: color ?? theme.colorScheme.primary.withOpacity(0.1),
            minHeight: height));
  }
}
