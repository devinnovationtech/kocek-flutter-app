// Flutter Mobile Scanner

/*import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:kocek_app/utils/widget/kocek_loading.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class KocekQRScanner extends StatefulWidget {
  const KocekQRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Child();
}

class _Child extends State<KocekQRScanner> with SingleTickerProviderStateMixin {
  MobileScannerController controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, returnImage: false);
  late bool torch = controller.torchEnabled;
  String? value;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    Widget iconButton(
            {required Widget child, void Function()? onTap, String? tooltip}) =>
        DecoratedBox(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  color: my.color.background.withOpacity(0.1),
                  spreadRadius: 2.5)
            ]),
            child: InkMaterial(
                tooltip: tooltip,
                onTap: onTap,
                color: my.color.onBackground,
                shapeBorder: const CircleBorder(),
                child: SizedBox(width: 40, height: 40, child: child)));

    return Scaffold(
        backgroundColor: const Color(0xff242B32),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          MobileScanner(
              placeholderBuilder: (p0, p1) => Container(
                  width: my.query.size.width,
                  height: my.query.size.height,
                  alignment: Alignment.center,
                  color: my.color.onBackground,
                  child: KocekLoading(
                      duration: duration, color: my.color.background)),
              controller: controller,
              fit: BoxFit.cover,
              startDelay: true,
              onDetect: (barcode) async {
                if (barcode.barcodes.isNotEmpty) {
                  String? value = barcode.barcodes.first.rawValue?.toString();
                  if (value != null && this.value == null) {
                    setState(() => this.value = value);
                    context.close(this.value);
                  }
                }
              }),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconButton(
                              tooltip: "Lampu",
                              onTap: () {
                                controller.toggleTorch();
                                setState(() => torch = !torch);
                              },
                              child: Icon(
                                  torch ? Icons.flash_on : Icons.flash_off,
                                  size: 20.0,
                                  color: my.color.background)),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kToolbarHeight),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: my.color.background
                                                .withOpacity(0.1),
                                            spreadRadius: 5)
                                      ]),
                                  child: InkMaterial(
                                      shapeBorder: const CircleBorder(),
                                      color: my.color.onBackground,
                                      onTap: () => context.close(),
                                      padding: insetAll(padding * 0.85),
                                      child: Icon(Icons.clear,
                                          color: my.color.background),
                                      tooltip: "Keluar"))),
                          iconButton(
                              tooltip: "Kamera",
                              onTap: () => controller.switchCamera(),
                              child: Icon(Icons.flip_camera_android,
                                  size: 20.0, color: my.color.background))
                        ]))
              ])
        ]));
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWithZoom extends StatefulWidget {
  const BarcodeScannerWithZoom({Key? key}) : super(key: key);

  @override
  _BarcodeScannerWithZoomState createState() => _BarcodeScannerWithZoomState();
}

class _BarcodeScannerWithZoomState extends State<BarcodeScannerWithZoom>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
  );

  bool isStarted = true;
  double _zoomFactor = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                onDetect: (barcode) {
                  setState(() {
                    this.barcode = barcode;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    children: [
                      Slider(
                        value: _zoomFactor,
                        onChanged: (value) {
                          setState(() {
                            _zoomFactor = value;
                            controller.setZoomScale(value);
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: ValueListenableBuilder(
                              valueListenable: controller.torchState,
                              builder: (context, state, child) {
                                if (state == null) {
                                  return const Icon(
                                    Icons.flash_off,
                                    color: Colors.grey,
                                  );
                                }
                                switch (state as TorchState) {
                                  case TorchState.off:
                                    return const Icon(
                                      Icons.flash_off,
                                      color: Colors.grey,
                                    );
                                  case TorchState.on:
                                    return const Icon(
                                      Icons.flash_on,
                                      color: Colors.yellow,
                                    );
                                }
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.toggleTorch(),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: isStarted
                                ? const Icon(Icons.stop)
                                : const Icon(Icons.play_arrow),
                            iconSize: 32.0,
                            onPressed: () => setState(() {
                              isStarted
                                  ? controller.stop()
                                  : controller.start();
                              isStarted = !isStarted;
                            }),
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 200,
                              height: 50,
                              child: FittedBox(
                                child: Text(
                                  barcode?.barcodes.first.rawValue ??
                                      'Scan something!',
                                  overflow: TextOverflow.fade,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: ValueListenableBuilder(
                              valueListenable: controller.cameraFacingState,
                              builder: (context, state, child) {
                                if (state == null) {
                                  return const Icon(Icons.camera_front);
                                }
                                switch (state as CameraFacing) {
                                  case CameraFacing.front:
                                    return const Icon(Icons.camera_front);
                                  case CameraFacing.back:
                                    return const Icon(Icons.camera_rear);
                                }
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.switchCamera(),
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.image),
                            iconSize: 32.0,
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              // Pick an image
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image != null) {
                                if (await controller.analyzeImage(image.path)) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Barcode found!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No barcode found!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/