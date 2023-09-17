import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';

class KocekPagination extends StatefulWidget {
  const KocekPagination(
      {Key? key, this.margin, this.controller, this.autoDispose = true})
      : super(key: key);
  final EdgeInsets? margin;
  final KocekPaginationController? controller;
  final bool autoDispose;

  @override
  State<KocekPagination> createState() => _Child();
}

class _Child extends KocekPaginationState {
  late KocekPaginationController controller =
      widget.controller ?? KocekPaginationController();

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

  @override
  Widget builder(KocekShortcut my) {
    return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: Row(children: [
          Expanded(
              child: Text(
                  "${controller.value.itemFirstIndex + 1}-${controller.value.itemLastIndex} dari ${controller.value.totalLength} Hasil",
                  style: my.text.labelSmall?.copyWith(
                      color: my.color.onBackground.withOpacity(0.5),
                      fontSize: 11.0))),
          InkMaterial(
              onTap: () {
                controller.set(
                    index: controller.value.index - 1 < 0
                        ? 0
                        : controller.value.index - 1);
              },
              borderRadius: radiusAll(circular(radius)),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: radiusAll(circular(radius)),
                      border: Border.all(
                          width: 1, color: my.color.primary.withOpacity(0.1))),
                  width: buttonHeight,
                  height: buttonHeight,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_left, color: my.color.onBackground)),
              color: my.color.background),
          Container(
              decoration: BoxDecoration(
                  color: my.color.primary.withOpacity(0.05),
                  borderRadius: radiusAll(circular(radius)),
                  border: Border.all(
                      width: 1, color: my.color.primary.withOpacity(0.1))),
              width: buttonHeight,
              height: buttonHeight,
              alignment: Alignment.center,
              margin: insetAxis(x: padding * 0.5),
              child: Text("${controller.value.index + 1}",
                  style: my.text.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: my.color.onBackground,
                      fontSize: 11.0))),
          InkMaterial(
              onTap: () {
                controller.set(
                    index: controller.value.index + 1 >=
                            controller.value.pageLength
                        ? controller.value.pageLength
                        : controller.value.index + 1);
              },
              borderRadius: radiusAll(circular(radius)),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: radiusAll(circular(radius)),
                      border: Border.all(
                          width: 1, color: my.color.primary.withOpacity(0.1))),
                  width: buttonHeight,
                  height: buttonHeight,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_right, color: my.color.onBackground)),
              color: my.color.background)
        ]));
  }
}

class KocekPaginationState extends State<KocekPagination> {
  Widget builder(KocekShortcut my) => const Placeholder();

  @override
  Widget build(BuildContext context) => builder(KocekShortcut.of(context));
}

class KocekPaginationModel<T extends Object> extends Equatable {
  const KocekPaginationModel(
      {required this.index, required this.itemLength, required this.list})
      : totalLength = list.length,
        pageLength = list.length == 0 ? 0 : list.length ~/ itemLength,
        itemFirstIndex = itemLength * index >= list.length
            ? list.length
            : itemLength * index,
        itemLastIndex = itemLength * (index + 1) >= list.length
            ? list.length
            : itemLength * (index + 1);

  /// length of list, for example :
  /// ```dart
  /// List<Widget> abc = [Text("1"), Text("2")];
  /// totalLength = 2;
  /// ```
  final int totalLength;

  final List<T> list;

  /// length of item per page, by default it's set as 10.
  final int itemLength;

  /// total page divided by item length per page.
  final int pageLength;

  /// Current index of page.
  final int index;

  /// Curent starting index of item in list.
  final int itemFirstIndex;

  /// Curent ending index of item in list.
  final int itemLastIndex;

  KocekPaginationModel<T> copyWith(
          {int? index, int? itemLength, List<T>? list}) =>
      KocekPaginationModel(
          index: index ?? this.index,
          itemLength: itemLength ?? this.itemLength,
          list: list ?? this.list);

  @override
  List<Object?> get props => [
        "index: $index",
        "page_length: $pageLength",
        "item_length: $itemLength",
        "total_length: $totalLength",
        "item_first_index: $itemFirstIndex",
        "item_last_index: $itemLastIndex"
      ];
}

class KocekPaginationController<T extends Object>
    extends ValueNotifier<KocekPaginationModel<T>> {
  KocekPaginationController({KocekPaginationModel<T>? value})
      : super(value ??
            KocekPaginationModel<T>(index: 0, itemLength: 10, list: const []));
  List<T> get sublist =>
      value.list.sublist(value.itemFirstIndex, value.itemLastIndex);

  void set({int? index, int? itemLength, List<T>? list}) {
    value = value.copyWith(index: index, itemLength: itemLength, list: list);
    notifyListeners();
  }
}
