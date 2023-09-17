import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

import '../static/constant_variable.dart';

class FileSelectorSheet extends StatelessWidget {
  const FileSelectorSheet({Key? key, this.base64 = false}) : super(key: key);
  final bool base64;

  Future<String?> openWith(BuildContext context) {
    return showModalBottomSheet<String?>(
        context: context,
        backgroundColor: transparent,
        builder: (_) => const FileSelectorSheet());
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int x = 0; x < 2; x++)
            InkMaterial(
                onTap: () async {
                  if (x == 0) {
                    try {
                      /* final cameras = await availableCameras();

                      CameraDescription backCamera = cameras.firstWhere(
                          (body) =>
                              body.lensDirection == CameraLensDirection.back);
                      CameraDescription frontCamera = cameras.firstWhere(
                          (body) =>
                              body.lensDirection == CameraLensDirection.front);
                      String? path = await showDialog(
                          context: context,
                          builder: (context) => CustomCameraPage(
                              frontCamera: frontCamera,
                              backCamera: backCamera));*/

                      String? path =
                          (await KocekFunction.pickImage(context))?.path;
                      if (path != null) {
                        if (base64) {
                          String header =
                              "data:image/${path.split('.').last};base64,";
                          var content = await File(path).readAsBytes();
                          context.close(header + base64Encode(content));
                        } else {
                          context.close(path);
                        }
                      } else {
                        context.close();
                      }
                    } catch (e) {
                      BugSheet(
                              title:
                                  "Aplikasi Membutuhkan Kamera Depan & Belakang",
                              content: "$e",
                              pagePath:
                                  "src/etc/widget/file_selector_sheet.dart",
                              statePath: "Camera Package")
                          .openWith(context);
                    }
                  } else if (x == 1) {
                    XFile? image = await KocekFunction.pickImage(context,
                        source: ImageSource.gallery);
                    if (image?.path != null) {
                      if (base64) {
                        String header =
                            "data:image/${image!.path.split('.').last};base64,";
                        var content = await image.readAsBytes();
                        context.close(header + base64Encode(content));
                      } else {
                        context.close(image!.path);
                      }
                    } else {
                      context.close();
                    }
                  }
                },
                color: my.color.background,
                child: Container(
                    height: kToolbarHeight,
                    padding: insetAxis(x: padding),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: my.color.primary.withOpacity(0.1)))),
                    child: Row(children: [
                      // Icons
                      Icon([Icons.camera_alt, Icons.upload_file_rounded][x],
                          color: [my.color.primary, my.color.tertiary][x]),
                      const SizedBox(width: padding),
                      Text(["Kamera", "File"][x],
                          style: my.text.labelMedium?.copyWith(
                              fontSize: 14, color: my.color.onBackground),
                          textAlign: TextAlign.start)
                    ])))
        ]);
  }
}
