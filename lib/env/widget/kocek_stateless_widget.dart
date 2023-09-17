import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_shortcut.dart';

class KocekStatelessWidget extends StatelessWidget {
  const KocekStatelessWidget({Key? key}) : super(key: key);

  Widget builder(KocekShortcut my) => const Placeholder();

  @override
  Widget build(BuildContext context) {
    return builder(KocekShortcut.of(context));
  }
}
