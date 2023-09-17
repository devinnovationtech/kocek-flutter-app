part of '../widget/kocek_image_uploader.dart';

class KocekImageUploaderPageController extends State<KocekImageUploader> {
  Widget builder(KocekShortcut my) => const Placeholder();
  @override
  Widget build(BuildContext context) => builder(KocekShortcut.of(context));

  late KocekImageUploaderController controller =
      widget.controller ?? KocekImageUploaderController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted && controller.value.startsWith("http")) setState(() {});
      if (!controller.value.startsWith("http")) {
        context.read<KocekImageUploaderCubit>().go(path: controller.value);
      }
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
            context.read<KocekImageUploaderCubit>().go(path: path);
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
