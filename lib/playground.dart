import 'package:flutter/material.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/kocek_multi_dropdown.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

class Playground extends StatefulWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  DropdownController controller = DropdownController();
  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);

    return Scaffold(
        backgroundColor: my.color.background,
        body: SafeArea(
            child: KocekMultiDropdwon(
                topText: "Mekanik",
                hint: "Belum Dipilih",
                margin: inset(padding, padding, padding, 0.0),
                controller: controller,
                values: List.generate(10, (x) => "User ${x + 1}"))));
  }
}
