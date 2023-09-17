import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/widget/kocek_photo_selector/controller/kocek_photo_selector_controller.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
part '../controller/kocek_photo_selector_state_controller.dart';

class KocekPhotoSelector extends StatefulWidget {
  const KocekPhotoSelector(
      {Key? key,
      this.topText,
      this.margin,
      this.padding,
      this.controller,
      this.autoDispose = true})
      : super(key: key);
  final String? topText;
  final EdgeInsets? margin, padding;
  final KocekPhotoSelectorController? controller;
  final bool autoDispose;

  @override
  State<KocekPhotoSelector> createState() => _Child();
}

class _Child extends KocekPhotoSelectorStateController {
  @override
  Widget builder(KocekShortcut my) {
    return Container(
        margin: widget.margin,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (widget.topText != null)
            Padding(
                padding: insetOn(bottom: radius),
                child: Text(widget.topText!,
                    style: my.text.labelSmall?.copyWith(
                        color: my.color.onBackground.withOpacity(0.5),
                        fontSize: 11.0))),
          Container(
              padding: widget.padding ?? insetAll(padding * 0.5),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(circular(radius)),
                  border: Border.all(
                      width: 1.5, color: my.color.primary.withOpacity(0.1))),
              alignment: Alignment.center,
              child: controller.value.isEmpty
                  ? Column(children: [
                      Expanded(
                          child: InkMaterial(
                              onTap: onTap,
                              color: my.color.background,
                              borderRadius: BorderRadius.all(circular(radius)),
                              child: SizedBox(
                                  width: 150,
                                  child: Icon(Icons.upload_file_rounded,
                                      color: my.color.primary.withOpacity(0.1),
                                      size: 75)))),
                      const SizedBox(height: padding * 0.5),
                      Text("Pilih foto untuk diunggah",
                          style: my.text.labelSmall?.copyWith(
                              fontSize: 11.0, color: my.color.onBackground))
                    ])
                  : Container(
                      decoration: BoxDecoration(
                          color: my.color.background,
                          border: Border.all(
                              width: 1.5,
                              color: my.color.primary.withOpacity(0.1))),
                      width: 115,
                      height: 175,
                      child: InkWell(
                        onTap: onTap,
                        child: CustomImage(
                            source: controller.value, fit: BoxFit.cover),
                      )))
        ]));
  }
}
