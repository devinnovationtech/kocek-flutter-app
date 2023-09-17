import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';

class KocekError extends StatelessWidget {
  const KocekError(
      {Key? key,
      this.minusWidth = 0.0,
      this.minusHeight = 0.0,
        this.onRefresh,
      required this.title,
      required this.content,
      required this.statepath,
      required this.pagepath})
      : super(key: key);

  factory KocekError.withModel(KocekReportModel model,
          {required String statepath, required String pagepath, void Function()? onRefresh}) =>
      KocekError(onRefresh:onRefresh,
          title: model.title,
          content: model.content,
          statepath: statepath,
          pagepath: pagepath);
final void Function()? onRefresh;
  final double minusWidth, minusHeight;
  final String title, content, statepath, pagepath;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width - minusWidth,
        height: size.height - minusHeight,
        alignment: Alignment.center,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BugCatcher(onRefresh: onRefresh,
                  title: title,
                  content: content,
                  statePath: statepath,
                  pagePath: pagepath)
            ]));
  }
}
