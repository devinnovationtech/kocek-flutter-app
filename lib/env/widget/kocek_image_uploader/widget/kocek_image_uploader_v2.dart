import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/widget/kocek_image_uploader/widget/kocek_image_uploader.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/image_viewer.dart';

part '../controller/kocek_image_uploader_v2_page_controller.dart';

class KocekImageUploaderV2 extends StatefulWidget {
  const KocekImageUploaderV2(
      {Key? key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.type = KocekImageUploaderType.picker,
      this.autoDispose = true})
      : super(key: key);
  final KocekImageUploaderController? controller;
  final KocekImageUploaderType type;
  final bool autoDispose;
  final String? hintText;
  final void Function(String value)? onChanged;

  @override
  State<KocekImageUploaderV2> createState() => _Child();
}

class _Child extends KocekImageUploaderPageV2Controller {
  @override
  Widget builder(KocekShortcut my) {
    BorderRadius borderRadius = widget.hintText != null
        ? radiusOn(topLeft: circular(radius), topRight: circular(radius))
        : radiusAll(circular(radius));
    return Container(
        width: 106,
        decoration: BoxDecoration(borderRadius: borderRadius),
        margin: const EdgeInsets.only(left: 20.0, top: 8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Material(
              color: my.color.background,
              borderRadius: borderRadius,
              child: InkWell(
                  onTap: onTap,
                  borderRadius: borderRadius,
                  child: Container(
                      height: 106,
                      width: 106,
                      clipBehavior: Clip.hardEdge,
                      padding: controller.value.isEmpty
                          ? const EdgeInsets.all(8.0)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: my.color.primary.withOpacity(0.5)),
                          borderRadius: borderRadius),
                      child: CustomImage(
                          source: controller.value, fit: BoxFit.cover)))),
          if (widget.hintText != null)
            GestureDetector(
              onTap: onTap,
              child: Container(
                  width: 106,
                  decoration: BoxDecoration(
                      color: my.color.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: circular(radius),
                          bottomRight: circular(radius))),
                  alignment: Alignment.center,
                  padding: insetAxis(y: padding * 0.5),
                  child: Text(widget.hintText!,
                      style: my.text.labelSmall?.copyWith(
                          color: my.color.background, fontSize: 11.0))),
            )
        ]));
  }
}
