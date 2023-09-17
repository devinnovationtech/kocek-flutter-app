import 'package:flutter/material.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';
import 'package:lottie/lottie.dart';

import '../static/constant_variable.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({Key? key, required this.source}) : super(key: key);
  final String? source;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    String source = this.source ?? 'assets/poto.png';

    return Center(
        child: Padding(
            padding: insetAll(20.0),
            child: InkMaterial(
                borderRadius: radiusAll(circular(radius)),
                color: my.color.background,
                onTap: () => context.close(),
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: radiusAll(circular(radius)),
                    child: DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                            borderRadius: radiusAll(circular(radius)),
                            border: Border.all(
                                width: 1.5, color: my.color.primary)),
                        child: CustomImage(
                            source: source,
                            fit: BoxFit.fill,
                            onError: Padding(
                                padding: insetAll(padding),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                          padding: insetOn(bottom: padding),
                                          child: Lottie.asset(
                                              "assets/animation/image.json",
                                              width: 100.0)),
                                      Text("Gambar Gagal Dimuat",
                                          style: my.text.labelSmall?.copyWith(
                                              color: my.color.primary),
                                          textAlign: TextAlign.center)
                                    ]))))))));
  }

  void asDialog(BuildContext context) => showDialog(
      context: context,
      barrierColor:
          ThemeShortcut.of(context).color.onBackground.withOpacity(0.75),
      builder: (_) => this);
}
