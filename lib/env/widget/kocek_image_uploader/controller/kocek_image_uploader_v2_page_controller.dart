part of '../widget/kocek_image_uploader_v2.dart';

class KocekImageUploaderPageV2Controller extends State<KocekImageUploaderV2> {
  Widget builder(KocekShortcut my) => const Placeholder();
  @override
  Widget build(BuildContext context) => builder(KocekShortcut.of(context));

  late KocekImageUploaderController controller =
      widget.controller ?? KocekImageUploaderController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.autoDispose) controller.dispose();
    super.dispose();
  }

  Future<void> onTap() async {
    switch (widget.type) {
      case KocekImageUploaderType.picker:
        {
          String? path = (await KocekFunction.pickImage(context))?.path;
          if (path != null) {
            controller.value = path;
          }
        }
        break;
      case KocekImageUploaderType.viewer:
        {
          if (controller.value.isNotEmpty) {
            ImageViewer(source: controller.value).asDialog(context);
          }
        }
        break;
    }
  }
}
