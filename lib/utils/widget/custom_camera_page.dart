import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/image_viewer.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/kocek_loading.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class CustomCameraPage extends StatefulWidget {
  const CustomCameraPage({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  _CustomCameraPageState createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends State<CustomCameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  String? path;
  bool flip = false;
  bool light = false;
  int index = 0;

  void flipCamera() {
    int index = this.index + 1;
    if (index < widget.cameras.length) {
      setState(() {
        this.index = index;
        light = false;
      });
    } else {
      setState(() {
        this.index = 0;
        light = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.cameras[index], ResolutionPreset.medium,
        enableAudio: false);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    Widget iconButton(
            {required Widget child, void Function()? onTap, String? tooltip}) =>
        DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                color: my.color.background.withOpacity(0.1), spreadRadius: 2.5)
          ]),
          child: InkMaterial(
              tooltip: tooltip,
              onTap: onTap,
              color: my.color.onBackground,
              shapeBorder: const CircleBorder(),
              child: SizedBox(width: 40, height: 40, child: child)),
        );

    return Scaffold(
        backgroundColor: my.color.onBackground,
        body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_controller);
                        } else {
                          return KocekLoading(
                              duration: duration, color: my.color.background);
                        }
                      }))
            ]),
        bottomNavigationBar: Padding(
          padding: insetAll(padding),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconButton(
                    onTap: () => ImageViewer(source: "$path").asDialog(context),
                    child: ClipRRect(
                        borderRadius: radiusAll(circular(100)),
                        child: CustomImage(
                            source: "$path",
                            errorColor: my.color.background,
                            fit: BoxFit.cover)),
                    tooltip: "Gambar"),
                iconButton(
                    onTap: () async {
                      setState(() => light = !light);

                      await _initializeControllerFuture;
                      _controller.setFlashMode(
                          light == true ? FlashMode.torch : FlashMode.off);
                    },
                    child: Icon(
                        light == true ? Icons.flash_off : Icons.flash_on,
                        color: my.color.background,
                        size: 20),
                    tooltip: "Lampu"),
                DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: my.color.background.withOpacity(0.1),
                              spreadRadius: 5)
                        ]),
                    child: InkMaterial(
                        shapeBorder: const CircleBorder(),
                        color: my.color.onBackground,
                        onTap: () async {
                          try {
                            await _initializeControllerFuture;
                            final image = await _controller.takePicture();
                            setState(() {
                              path = image.path;
                              light = false;
                            });
                          } catch (e) {
                            // do nothing
                          }
                        },
                        padding: insetAll(padding * 0.85),
                        child:
                            Icon(Icons.camera_alt, color: my.color.background),
                        tooltip: "Ambil Foto")),
                iconButton(
                    onTap: () {
                      flipCamera();
                      _controller = CameraController(
                          widget.cameras[index], ResolutionPreset.medium,
                          enableAudio: false);
                      _initializeControllerFuture = _controller.initialize();
                    },
                    child: Icon(Icons.flip_camera_android,
                        color: my.color.background, size: 20),
                    tooltip: "Ganti Kamera"),
                iconButton(
                    onTap: () => context.close(path),
                    child: Icon(path != null ? Icons.check : Icons.clear,
                        color: my.color.background, size: 20),
                    tooltip: "Tutup")
              ]),
        ));
  }
}
