import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class KocekCartController extends ValueNotifier<List<KocekCartModel>> {
  KocekCartController({List<KocekCartModel> values = const []}) : super(values);

  void set(List<KocekCartModel> values) {
    value = values;
    notifyListeners();
  }
}

class KocekCart extends StatefulWidget {
  const KocekCart(
      {Key? key, required this.controller, this.readOnly = false, this.label})
      : super(key: key);
  final KocekCartController controller;
  final bool readOnly;
  final String? label;

  @override
  _KocekCardState createState() => _KocekCardState();
}

class _KocekCardState extends State<KocekCart> {
  late List<KocekCartModel> values = widget.controller.value;
  late int total = values.isEmpty ? 1 : values.length;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.label != null)
        Padding(
            padding: const EdgeInsets.fromLTRB(padding, padding, padding, 0),
            child: Text(widget.label!,
                style: my.text.labelMedium?.copyWith(fontSize: 14))),
      SingleChildScrollView(
          child: Column(
              children: List.generate(
                  total,
                  (x) => KocekCartItem(
                      readOnly: widget.readOnly,
                      label: values
                          .firstWhere((e) => e.id == x,
                              orElse: () => KocekCartModel(
                                  id: x, sparepart: "", quantity: ""))
                          .sparepart,
                      quantity: values
                          .firstWhere((e) => e.id == x,
                              orElse: () => KocekCartModel(
                                  id: x, sparepart: "", quantity: ""))
                          .quantity,
                      id: x,
                      margin: const EdgeInsets.fromLTRB(
                          padding, padding * 0.5, padding, padding * 0.5),
                      onChanged: (value) {
                        if (values.any((body) => body.id == value.id)) {
                          values
                            ..removeWhere((body) => body.id == value.id)
                            ..add(value);
                        } else {
                          values.add(value);
                        }
                        widget.controller.set(values);
                      }))
                ..add(widget.readOnly
                    ? const SizedBox(height: padding * 0.5)
                    : CustomTextButton(
                        onTap: () {
                          if (values.any((e) => e.sparepart.isEmpty)) {
                            context.alert(
                                label: "Isi Sparepart yg masih kosong dulu");
                          } else if (values.any((e) => e.quantity.isEmpty)) {
                            context.alert(label: "Isi Jumlah Sparepart Dahulu");
                          } else {
                            setState(() => total++);
                          }
                        },
                        color: my.color.background,
                        border: Border.all(
                            width: 1,
                            color: my.color.onBackground.withOpacity(0.3)),
                        text: "TAMBAH SPAREPART",
                        splashColor: my.color.primary.withOpacity(0.1),
                        textStyle: my.text.labelMedium?.copyWith(
                            color: my.color.onBackground, fontSize: 12.0),
                        margin:
                            inset(padding, padding * 0.5, padding, padding)))))
    ]);
  }
}

class KocekCartItem extends StatelessWidget {
  const KocekCartItem(
      {Key? key,
      required this.id,
      this.label,
      this.margin,
      this.readOnly = false,
      required this.onChanged,
      this.quantity})
      : super(key: key);
  final int id;
  final void Function(KocekCartModel value) onChanged;
  final String? label, quantity;
  final EdgeInsets? margin;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    TextEditingController sparepart = TextEditingController(text: label);
    TextEditingController quantity = TextEditingController(text: this.quantity);
    onChanged(KocekCartModel(
        id: id, sparepart: sparepart.text, quantity: quantity.text));

    return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              flex: 3,
              child: CustomTextField(
                  editable: !readOnly,
                  hintText: "Sparepart",
                  hintStyle: my.text.labelSmall
                      ?.copyWith(color: my.color.onBackground.withOpacity(0.5)),
                  controller: sparepart,
                  onChanged: (value) => onChanged(KocekCartModel(
                      id: id, sparepart: value, quantity: quantity.text)),
                  border: Border.all(
                      width: 1,
                      color: my.color.onBackground.withOpacity(0.1)))),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
              child: Text("x")),
          Flexible(
              flex: 1,
              child: CustomTextField(
                  editable: !readOnly,
                  hintText: "Jumlah",
                  controller: quantity,
                  hintStyle: my.text.labelSmall
                      ?.copyWith(color: my.color.onBackground.withOpacity(0.5)),
                  onChanged: (value) => onChanged(KocekCartModel(
                      id: id, sparepart: sparepart.text, quantity: value)),
                  textAlign: TextAlign.center,
                  filter: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  inputType: TextInputType.number,
                  border: Border.all(
                      width: 1, color: my.color.onBackground.withOpacity(0.1))))
        ]));
  }
}

class KocekCartModel extends Equatable {
  const KocekCartModel(
      {required this.id, required this.sparepart, required this.quantity});
  final int id;
  final String sparepart, quantity;

  factory KocekCartModel.fromJson(int id, Map<String, dynamic> json) {
    return KocekCartModel(
        id: id,
        sparepart: json["sparepart_id"] ?? "",
        quantity: json["qty"] ?? "");
  }

  @override
  List<Object?> get props =>
      ["id: $id", "sparepart: $sparepart", "quantity: $quantity"];
}
