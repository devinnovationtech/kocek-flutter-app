import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/image_viewer.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekFilePicker extends StatefulWidget {
  const KocekFilePicker(
      {Key? key,
      this.autoDispose = true,
      this.editable = true,
      required this.controller,
      this.margin,
      this.bottomMargin,
      this.topText})
      : super(key: key);
  final bool autoDispose, editable;
  final KocekFilePickerController controller;
  final String? topText;
  final EdgeInsetsGeometry? margin, bottomMargin;

  @override
  _KocekFilePickerState createState() => _KocekFilePickerState();
}

class _KocekFilePickerState extends State<KocekFilePicker> {
  @override
  void initState() {
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextButton(
              text: !widget.editable && widget.controller.value.isEmpty
                  ? "Tidak Ada Document"
                  : !widget.editable && widget.controller.value.isNotEmpty
                      ? "1 Document"
                      : "Ambil Document",
              margin: widget.margin,
              topText: widget.topText,
              topTextStyle: my.text.labelSmall?.copyWith(
                  color: my.color.onBackground.withOpacity(0.5),
                  fontSize: 11.0),
              onTap: !widget.editable
                  ? null
                  : () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx'],
                      );

                      if (result != null) {
                        widget.controller.value = result.files.single.path!;
                      } else {
                        // User canceled the picker
                      }
                    },
              color: my.color.onBackground,
              textStyle: my.text.labelMedium
                  ?.copyWith(color: my.color.background, fontSize: 10.0)),
          if (widget.controller.value.isNotEmpty)
            Padding(
              padding: insetOn(top: padding),
              child: Stack(alignment: Alignment.topRight, children: [
                InkMaterial(
                    onTap: () => ImageViewer(source: widget.controller.value)
                        .asDialog(context),
                    child: Container(
                        padding: insetAll(padding),
                        decoration: BoxDecoration(
                            borderRadius: radiusAll(circular(radius)),
                            color: my.color.primary.withOpacity(0.1)),
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: radiusAll(circular(radius))),
                            child: CustomImage(
                                fit: BoxFit.cover,
                                source: widget.controller.value),
                            width: buttonHeight,
                            height: buttonHeight))),
                if (widget.editable)
                  Positioned(
                      right: padding * 0.5,
                      top: padding * 0.5,
                      child: InkMaterial(
                          color: my.color.error,
                          shapeBorder: const CircleBorder(),
                          padding: insetAll(2.0),
                          onTap: () {
                            widget.controller.value = "";
                          },
                          child: Icon(Icons.clear,
                              size: 15.0, color: my.color.background)))
              ]),
            )
        ]);
  }
}

class KocekFilePickerController extends ValueNotifier<String> {
  KocekFilePickerController({String? value}) : super(value ?? "");
}
