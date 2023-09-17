import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/kocek_expired.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../static/shortcut_variable.dart';

class BugCatcher extends StatelessWidget {
  const BugCatcher(
      {Key? key,
      required this.title,
      required this.content,
      required this.statePath,
      this.button,
      this.icon,
      this.dark = true,
      this.onRefresh,
      required this.pagePath})
      : super(key: key);
  final String title;
  final String content;
  final String statePath;
  final String pagePath;
  final bool dark;
  final Widget? button, icon;
  final void Function()? onRefresh;

  factory BugCatcher.withModel(KocekReportModel model,
          {void Function()? onRefresh,
          required String statePath,
          required String pagePath}) =>
      BugCatcher(
          title: model.title,
          content: model.content,
          onRefresh: onRefresh,
          statePath: statePath,
          pagePath: pagePath);

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (content.contains('Http status error [403]')) {
        context.to(child: const KocekExpired());
      }
    });

    return Container(
        alignment: Alignment.center,
        padding: insetAll(20.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          icon ?? Lottie.asset("assets/animation/error.json"),
          Stack(alignment: Alignment.center, children: [
            Transform.translate(
                offset: const Offset(0.0, -padding * 3),
                child: Text("‟ $title ”",
                    style: my.text.labelSmall?.copyWith(
                        color:
                            (dark ? my.color.onBackground : my.color.background)
                                .withOpacity(0.75)),
                    textAlign: TextAlign.center)),
            button ??
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkMaterial(
                      color: my.color.onBackground.withOpacity(0.75),
                      splashColor: my.color.error,
                      borderRadius: radiusAll(circular(100.0)),
                      onTap: () => BugSheet(
                              title: title,
                              content: content,
                              pagePath: pagePath,
                              statePath: statePath)
                          .openWith(context),
                      child: Container(
                          height: buttonHeight,
                          alignment: Alignment.center,
                          padding: insetAxis(x: padding),
                          child: Text("Baca Selengkapnya",
                              style: TextStyle(color: my.color.background)))),
                  if (onRefresh != null)
                    InkMaterial(
                        onTap: onRefresh,
                        margin: insetOn(left: padding / 2),
                        color: my.color.onBackground.withOpacity(0.75),
                        splashColor: my.color.error,
                        shapeBorder: const CircleBorder(),
                        child: SizedBox(
                            width: buttonHeight,
                            height: buttonHeight,
                            child: Icon(Icons.refresh_outlined,
                                color: my.color.background)))
                ])
          ])
        ]));
  }
}

class BugSheet extends StatelessWidget {
  const BugSheet(
      {Key? key,
      required this.title,
      required this.content,
      required this.pagePath,
      required this.statePath})
      : super(key: key);
  final String title, content, pagePath, statePath;

  factory BugSheet.withModel(KocekReportModel model,
          {required String pagePath, required String statePath}) =>
      BugSheet(
          title: model.title,
          content: model.content,
          pagePath: pagePath,
          statePath: statePath);

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: my.query.size.height / 2),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              constraints: const BoxConstraints(minHeight: kToolbarHeight),
              color: my.color.error,
              padding: insetAxis(x: padding),
              child: Row(children: [
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title,
                          style: my.kocekText.label1Medium?.copyWith(
                              fontSize: 14, color: my.color.background),
                          textAlign: TextAlign.start),
                      FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (_, AsyncSnapshot<PackageInfo> snap) {
                            if (snap.connectionState == ConnectionState.done &&
                                snap.data != null) {
                              return Text(
                                  "${KocekAsset.app_label} v${snap.data?.version ?? 0.0}",
                                  textAlign: TextAlign.end,
                                  style: my.kocekText.label1Regular.copyWith(
                                      color:
                                          my.color.background.withOpacity(0.5),
                                      fontSize: 10));
                            } else {
                              return const SizedBox();
                            }
                          })
                    ])),
                InkMaterial(
                    tooltip: "Salin Rincian Masalah",
                    shapeBorder: const CircleBorder(),
                    onTap: () async {
                      PackageInfo package = await PackageInfo.fromPlatform();
                      String message =
                          'TITLE: $title\nDATE: ${DateTime.now()}\nSTATE PATH: $statePath\nPAGE PATH: $pagePath\nCONTENT: $content\nVERSION: ${package.version}';
                      await Clipboard.setData(ClipboardData(text: message));
                      context.close();
                      context.alert(
                          label: "Rincian Masalah Berhasil Disalin",
                          color: my.color.tertiary);
                    },
                    child: Padding(
                        padding: insetAll(radius),
                        child: Icon(Icons.copy,
                            size: 20, color: my.color.background)))
              ])),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: my.color.background),
                  child: Scrollbar(
                      child: SingleChildScrollView(
                          padding: insetAll(padding),
                          child: Text(KocekApi.parse(content),
                              textAlign: TextAlign.justify,
                              style: my.kocekText.label1Regular.copyWith(
                                  color:
                                      my.color.onBackground.withOpacity(0.75),
                                  fontSize: 11.0))))))
        ]));
  }

  Future<T?> openWith<T extends Object?>(BuildContext context) {
    if (content.contains('Http status error [403]')) {
      return context.to(child: const KocekExpired());
    } else {
      return showModalBottomSheet<T>(
          backgroundColor: transparent,
          barrierColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(0.85),
          context: context,
          builder: (_) => BugSheet(
              title: title,
              content: content,
              pagePath: pagePath,
              statePath: statePath));
    }
  }
}
