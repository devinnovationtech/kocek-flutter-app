import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/custom_textfield.dart';
import 'package:kocek_app/utils/widget/inkmaterial.dart';
import 'package:lottie/lottie.dart';

part 'kocek_dropdown_controller.dart';
part 'kocek_dropdown_model.dart';

class KocekDropdownSearch extends StatefulWidget {
  const KocekDropdownSearch(
      {Key? key,
      required this.controller,
      this.editable = true,
      this.topText,
      this.hint,
      this.topTextStyle,
      this.margin,
      this.onTap,
      this.labelName = "Name",
      this.labelID = "ID",
      this.autoDispose = true,
      this.color,
      required this.content})
      : super(key: key);
  final KocekDropdownController controller;
  final bool autoDispose, editable;
  final List<KocekDropdownModel> content;
  final String? topText, hint;
  final TextStyle? topTextStyle;
  final EdgeInsets? margin;
  final String labelName, labelID;
  final Color? color;
  final void Function()? onTap;

  @override
  _KocekDropdownSearchState createState() => _KocekDropdownSearchState();
}

class _KocekDropdownSearchState extends State<KocekDropdownSearch> {
  late int? value = (widget.controller.value ?? 0) > widget.content.length
      ? null
      : widget.controller.value == -1
          ? null
          : widget.controller.value;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var value = widget.controller.value;
      if (value != null && mounted) {
        setState(() => this.value = widget.controller.value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);
    String text() {
      if (value == null || value != null && value! >= widget.content.length) {
        return widget.hint ?? "Belum Dipilih";
      } else {
        return widget.content[value!].text;
      }
    }

    return CustomTextButton.rich(
        backgroundImage: false,
        onTap: () async {
          if (widget.onTap != null) {
            widget.onTap!();
          } else {
            if (widget.editable) {
              int? value = await context.to(
                  child: Center(
                      child: KocekDropdownSearchPage(
                          content: widget.content,
                          labelID: widget.labelID,
                          labelName: widget.labelName)));
              if (value != null) {
                widget.controller.value = value;
              }
            }
          }
        },
        color: widget.color ??
            (widget.editable
                ? my.color.background
                : my.color.primary.withOpacity(0.1)),
        border:
            Border.all(width: 1.5, color: my.color.primary.withOpacity(0.1)),
        margin: widget.margin,
        topText: widget.topText,
        topTextStyle: widget.topTextStyle ??
            my.text.labelSmall?.copyWith(
                color: my.color.onBackground.withOpacity(0.5), fontSize: 11.0),
        customText: Padding(
            padding: insetAxis(x: radius),
            child: Row(children: [
              Expanded(
                  child: Text(text(),
                      style: my.text.labelSmall?.copyWith(
                          fontSize: 12.0,
                          color: my.color.onBackground
                              .withOpacity(widget.editable ? 1 : 0.5)))),
              Icon(Icons.arrow_drop_down,
                  color: my.color.onBackground
                      .withOpacity(widget.editable ? 1 : 0.1))
            ])));
  }
}

class KocekDropdownSearchPage extends StatefulWidget {
  const KocekDropdownSearchPage(
      {Key? key,
      this.onChanged,
      required this.labelName,
      required this.labelID,
      this.searchWidget,
      this.autofocus = true,
      required this.content})
      : super(key: key);
  final List<KocekDropdownModel> content;
  final String labelName, labelID;
  final Widget? searchWidget;
  final bool autofocus;
  final void Function(int value)? onChanged;

  @override
  State<KocekDropdownSearchPage> createState() => _KocekDropdownSearchPageState();
}

class _KocekDropdownSearchPageState extends State<KocekDropdownSearchPage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    var my = KocekShortcut.of(context);

    return Scaffold(
        backgroundColor: my.color.background,
        body: SafeArea(
            child: Column(children: [
          CustomTextField(
              margin: insetAll(padding),
              border: Border.all(
                  width: 1, color: my.color.primary.withOpacity(0.25)),
              autofocus: widget.autofocus,
              onChanged: (search) => setState(() => this.search = search),
              prefixIcon: widget.searchWidget ??
                  InkMaterial(
                      onTap: () => context.close(),
                      child: Icon(Icons.arrow_back,
                          color: my.color.primary.withOpacity(0.5))),
              hintText: "Ketik untuk mencari",
              hintStyle: my.text.labelSmall?.copyWith(
                  color: my.color.primary.withOpacity(0.5), fontSize: 12.0)),
          Container(
              margin: insetAxis(x: padding),
              height: buttonHeight,
              decoration: BoxDecoration(
                  color: my.color.onBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: circular(radius), topRight: circular(radius))),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                      2,
                      (x) => Expanded(
                          flex: [4, 2][x],
                          child: Container(
                              padding: insetAxis(x: padding),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  [widget.labelName, widget.labelID][x]
                                      .toUpperCase(),
                                  style: my.text.labelMedium?.copyWith(
                                      fontSize: 12.0,
                                      color: my.color.background,
                                      fontWeight: FontWeight.bold))))))),
          Expanded(
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: inset(padding, 0, padding, padding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: circular(radius),
                          bottomRight: circular(radius))),
                  foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: circular(radius),
                          bottomRight: circular(radius)),
                      border: Border.all(
                          width: 1, color: my.color.primary.withOpacity(0.1))),
                  child: Builder(builder: (_) {
                    List<KocekDropdownModel> content =
                        widget.content.where((body) {
                      return body.text
                              .toUpperCase()
                              .contains(search.toUpperCase()) ||
                          body.code
                              .toUpperCase()
                              .contains(search.toUpperCase());
                    }).toList();
                    if (content.isEmpty) {
                      return Center(
                          child: Lottie.asset('assets/animation/empty.json',
                              width: 150.0));
                    } else {
                      var focus = FocusScope.of(context);
                      return Scrollbar(
                          child: ListView.builder(
                              itemCount: content.length,
                              itemBuilder: (_, x) => CustomTextButton.rich(
                                  edge: 0.0,
                                  height: -1,
                                  backgroundImage: false,
                                  onTap: () {
                                    focus.unfocus();
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(content[x].index);
                                    } else {
                                      context.close(content[x].index);
                                    }
                                  },
                                  customText: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          2,
                                          (y) => Expanded(
                                              flex: [4, 2][y],
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: insetAll(padding),
                                                  child: Text(
                                                      [
                                                        content[x].text,
                                                        content[x].code
                                                      ][y],
                                                      style: my.text.labelSmall
                                                          ?.copyWith(
                                                              fontWeight: [
                                                                FontWeight.bold,
                                                                FontWeight
                                                                    .normal
                                                              ][y],
                                                              color: my.color
                                                                  .onBackground,
                                                              fontSize:
                                                                  12.0)))))),
                                  textcase: KocekCase.capitalize,
                                  color: x.isOdd
                                      ? my.color.primary.withOpacity(0.05)
                                      : my.color.background)));
                    }
                  })))
        ])));
  }
}
