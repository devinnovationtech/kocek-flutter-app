part of '../widget/kocek_photo_selector.dart';

class KocekPhotoSelectorStateController extends State<KocekPhotoSelector> {
  @override
  Widget build(BuildContext context) => builder(KocekShortcut.of(context));

  Widget builder(KocekShortcut my) => const Placeholder();

  Future<void> onTap() async {
    var file = await KocekFunction.pickImage(context);
    if (file != null) {
      controller.value = file.path;
    }
  }

  late KocekPhotoSelectorController controller =
      widget.controller ?? KocekPhotoSelectorController();

  @override
  void initState() {
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) controller.dispose();
    super.dispose();
  }
}
