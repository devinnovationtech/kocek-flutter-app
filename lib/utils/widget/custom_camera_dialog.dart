import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_camera_page.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

import '../static/constant_variable.dart';

class CustomCameraDialog extends StatelessWidget {
  const CustomCameraDialog({Key? key}) : super(key: key);

  static Future<String?> onTap(BuildContext context) async {
    try {
      List<CameraDescription> cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception("Tidak ada satupun kamera");
      } else {
        String? path = await showDialog(
            context: context,
            builder: (context) => CustomCameraPage(cameras: cameras));
        return path;
      }
    } catch (e) {
      await BugSheet(
              title: "Aplikasi Gagal Mengakses Kamera",
              content: "$e",
              pagePath: "src/etc/widget/custom_camera_dialog.dart",
              statePath: "Camera Package")
          .openWith(context);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Container(
        decoration: BoxDecoration(
            color: my.color.primary,
            borderRadius: radiusAll(circular(padding))),
        margin: insetAll(padding),
        child: CustomTextButton(
            margin: insetAll(padding),
            text: "Camera",
            onTap: () => onTap(context),
            color:
                Color.lerp(my.color.background, my.color.onBackground, 0.25)));
  }
}
