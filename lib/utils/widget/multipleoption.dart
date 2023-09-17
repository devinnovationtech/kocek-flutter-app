import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/widget/kocek_image_uploader/widget/kocek_image_uploader.dart';
import 'package:kocek_app/env/widget/kocek_image_uploader/widget/kocek_image_uploader_v2.dart';
import 'package:kocek_app/utils/static/alphabet.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/widget/multipleoption_button.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

enum MultipleoptionType { healthy, vehicle, quiz }

class Multipleoption extends StatefulWidget {
  const Multipleoption.healthy(
      {Key? key,
      this.padding,
      this.captionController,
      this.requiredPhoto,
      required this.title,
      required this.options,
      this.showNote = false,
      this.index,
      this.photo,
      required this.camera,
      this.selected,
      this.caption,
      this.captionStyle,
      this.note,
      this.allowSelecting = true,
      this.pickORview = true})
      : type = MultipleoptionType.healthy,
        super(key: key);
  const Multipleoption.vehicle(
      {Key? key,
      required this.camera,
      this.requiredPhoto,
      this.padding,
      required this.title,
      required this.options,
      this.photo,
      this.index,
      this.showNote = false,
      this.selected,
      this.caption,
      this.captionStyle,
      this.note,
      this.captionController,
      this.allowSelecting = true,
      this.pickORview = true})
      : type = MultipleoptionType.vehicle,
        super(key: key);

  const Multipleoption.quiz(
      {Key? key,
      this.padding,
      this.showNote = false,
      this.allowSelecting = true,
      this.requiredPhoto,
      required this.title,
      required this.options,
      this.index,
      this.selected,
      this.caption,
      this.captionStyle,
      this.photo,
      this.captionController,
      this.note,
      required this.camera,
      this.pickORview = true})
      : type = MultipleoptionType.quiz,
        super(key: key);

  final String title;
  final bool camera;
  final bool? requiredPhoto;
  final List<MultipleoptionButton> options;
  final MultipleoptionType type;
  final String? caption;
  final TextStyle? captionStyle;
  final String? note;
  final bool showNote;
  final TextEditingController? captionController;

  /// Whether allowing user to select or not.
  final bool allowSelecting;

  /// Pick equals `true` and view equals `false`.
  final bool pickORview;

  final String? photo;

  /// Index of selected [MultipleoptionButton].
  final int? index;

  final EdgeInsetsGeometry? padding;

  /// Check whether user answer one of the option or not.
  final void Function(bool isSelected, int? index, String? photo,
      TextEditingController controller)? selected;

  @override
  State<Multipleoption> createState() => _MultipleoptionState();
}

class _MultipleoptionState extends State<Multipleoption> {
  late KocekImageUploaderController uploader =
      KocekImageUploaderController(value: widget.photo);

  /// Check whether options contains selected [MultipleoptionButton] or not.
  late bool selected =
      widget.options.where((element) => element.selected).isNotEmpty;

  /// Index of selected [MultipleoptionButton].
  late int? index = widget.index ??
      (selected
          ? widget.options.indexWhere((element) => element.selected)
          : null);

  late TextEditingController controller =
      (widget.captionController ?? TextEditingController())
        ..addListener(() {
          if (widget.selected != null) {
            widget.selected!(selected, index,
                uploader.value.isEmpty ? null : uploader.value, controller);
          }
        });

  /// Select [MultipleoptionButton] inside [Multipleoption].
  void select(int index) async {
    if (widget.requiredPhoto == true &&
        uploader.value.isEmpty &&
        widget.pickORview) {
      String? path = (await KocekFunction.pickImage(context))?.path;
      if (path != null) {
        setState(() {
          uploader.value = path;
          this.index = index;
          selected = true;
          if (widget.selected != null) {
            widget.selected!(selected, index,
                uploader.value.isEmpty ? null : uploader.value, controller);
          }
        });
      }
    } else if (widget.options[index].openCamera == true && widget.pickORview) {
      String? path = (await KocekFunction.pickImage(context))?.path;
      if (path != null) {
        setState(() {
          uploader.value = path;
          this.index = index;
          selected = true;
          if (widget.selected != null) {
            widget.selected!(selected, index,
                uploader.value.isEmpty ? null : uploader.value, controller);
          }
        });
      }
    } else {
      setState(() {
        this.index = index;
        selected = true;
        if (widget.selected != null) {
          widget.selected!(selected, index,
              uploader.value.isEmpty ? null : uploader.value, controller);
        }
      });
    }
  }

  void setImage(String image) => setState(() {
        uploader.value = image;
        widget.selected!(selected, index,
            uploader.value.isEmpty ? null : uploader.value, controller);
      });

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      widget.selected!(selected, index,
          uploader.value.isEmpty ? null : uploader.value, controller);
    }
    uploader.addListener(() {
      if (widget.selected != null) {
        widget.selected!(selected, index,
            uploader.value.isEmpty ? null : uploader.value, controller);
      }
    });
  }

  @override
  void dispose() {
    uploader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title,
                  textAlign: TextAlign.start,
                  style: widget.type == MultipleoptionType.healthy
                      ? my.text.labelMedium?.copyWith(
                          fontSize: 10, fontWeight: FontWeight.normal)
                      : my.text.labelMedium?.copyWith(color: my.color.primary)),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      for (int x = 0; x < widget.options.length; x++)
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(children: [
                              if (widget.type == MultipleoptionType.quiz)
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${alphabet[x]}.",
                                        style: my.text.labelSmall?.copyWith(
                                            color: my.color.primary))),
                              Expanded(
                                  child: MultipleoptionButton(
                                      selected: index == x,
                                      selectedColor:
                                          widget.options[x].selectedColor,
                                      text: widget.options[x].text,
                                      onTap:
                                          widget.options[x].openCamera == true
                                              ? () => select(x)
                                              : widget.allowSelecting
                                                  ? () => select(x)
                                                  : null))
                            ]))
                    ])),
                Builder(builder: (_) {
                  bool opened =
                      widget.camera == true && widget.requiredPhoto == true ||
                          index != null &&
                              index! >= 0 &&
                              index! < widget.options.length &&
                              widget.options[index!].openCamera;

                  return SizedBox(
                      width: opened ? null : 0,
                      child: Transform.translate(
                          offset: Offset(opened ? 0 : 160, 0),
                          child: KocekImageUploaderV2(
                              autoDispose: false,
                              controller: uploader,
                              hintText: widget.requiredPhoto == true
                                  ? "Wajib Foto"
                                  : null)));
                }),
                /*    Container(
                      width: 106,
                      decoration: BoxDecoration(
                          borderRadius: radiusAll(circular(radius))),
                      margin: const EdgeInsets.only(left: 20.0, top: 8.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                     
                        Material(
                            color: my.color.background,
                            borderRadius: radiusAll(circular(radius)),
                            child: InkWell(
                                onTap: () async {
                                  if (widget.pickORview) {
                                    String? path =
                                        (await KocekEnvironment.pickImage())
                                            ?.path;
                                    if (path != null) {
                                      setState(() {
                                        /*image =
                                            "data:image/${path.split(".").last};base64," +
                                                base64Encode(File(path)
                                                    .readAsBytesSync());*/
                                        image = path;
                                        if (widget.selected != null) {
                                          widget.selected!(selected, index,
                                              image, controller);
                                        }
                                      });
                                    }
                                  } else {
                                    if (widget.photo != null) {
                                      ImageViewer(source: widget.photo!)
                                          .asDialog(context);
                                    } else {
                                      /* do nothing */
                                    }
                                  }
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                    height: 106,
                                    width: 106,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: my.color.primary),
                                    child: widget.pickORview
                                        ? image != null
                                            ? CustomImage(
                                                source: image!,
                                                fit: BoxFit.cover)
                                            : Image.asset("assets/poto.png")
                                        : widget.photo != null
                                            ? CustomImage(
                                                source: image!,
                                                fit: BoxFit.cover)
                                            : Image.asset("assets/poto.png")))),
                        if (widget.pickORview && widget.requiredPhoto == true)
                          const Text("Wajib foto")
                      ]))*/
              ]),
              if (widget.note != null)
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text.rich(TextSpan(children: [
                      const TextSpan(text: "Catatan:\n"),
                      WidgetSpan(
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                color: my.color.onBackground.withOpacity(0.25),
                                child: Text(widget.note!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))))
                      ]))
                    ], style: const TextStyle(fontWeight: FontWeight.bold)))),
              if (widget.showNote ||
                  index != null &&
                      index! >= 0 &&
                      index! < widget.options.length &&
                      widget.options[index!].openNote)
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                    child: TextField(
                        controller: controller,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: widget.caption ?? "Tambah keterangan",
                            hintStyle: widget.captionStyle ??
                                const TextStyle(color: Color(0xffB6B6B6)))))
              else
                const SizedBox(height: padding * 2)
            ]));
  }
}
