import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/env/widget/kocek_image_uploader/cubit/kocek_image_uploader_cubit.dart';
import 'package:kocek_app/utils/animation/bouncing_animation.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_image.dart';
import 'package:kocek_app/utils/widget/image_viewer.dart';

part '../controller/kocek_image_uploader_page_controller.dart';
part '../controller/kocek_image_uploader_controller.dart';

enum KocekImageUploaderType { picker, viewer }

class KocekImageUploader extends StatefulWidget {
  const KocekImageUploader(
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

  static Widget onBloc(
          {Key? key,
          KocekImageUploaderController? controller,
          String? hintText,
          KocekImageUploaderType type = KocekImageUploaderType.picker,
          void Function(String value)? onChanged,
          bool autoDispose = true}) =>
      BlocProvider(
          create: (_) => KocekImageUploaderCubit(),
          child: KocekImageUploader(
              key: key,
              hintText: hintText,
              controller: controller,
              type: type,
              autoDispose: autoDispose,
              onChanged: onChanged));

  @override
  State<KocekImageUploader> createState() => _Child();
}

class _Child extends KocekImageUploaderPageController {
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
                      child: BlocConsumer<KocekImageUploaderCubit,
                          KocekImageUploaderStates>(listener: (_, state) {
                        if (state is KocekImageUploaderOnSucceed) {
                          context.alert(
                              label: state.model.message,
                              color: my.color.tertiary);
                          controller.value = state.model.path;
                        } else if (state is KocekImageUploaderOnFailed) {
                          context.alert(label: state.model.message);
                          controller.value = state.model.path;
                        } else if (state is KocekImageUploaderOnError) {
                          BugSheet(
                                  title: "Gagal Mengunggah Foto",
                                  content: state.model.message,
                                  pagePath:
                                      "env/widget/kocek_image_uploader/widget/kocek_image_uploader.dart",
                                  statePath:
                                      "env/widget/kocek_image_uploader/cubit/kocek_image_uploader_cubit.dart")
                              .openWith(context);
                          controller.value = state.model.path;
                        }
                      }, builder: (_, state) {
                        if (state is KocekImageUploaderOnGoing) {
                          return Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                BouncingAnimation(
                                    duration: duration,
                                    child: Icon(Icons.upload,
                                        color: my.color.primary)),
                                const SizedBox(height: padding),
                                Text("Uploading",
                                    style: my.text.labelSmall?.copyWith(
                                        color:
                                            my.color.primary.withOpacity(0.75),
                                        fontSize: 11.0))
                              ]));
                        }
                        return CustomImage(
                            source: controller.value, fit: BoxFit.cover);
                      })))),
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
