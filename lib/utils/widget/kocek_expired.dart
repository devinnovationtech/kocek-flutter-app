import 'package:flutter/material.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/extension/kocek_context.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/custom_textbutton.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';
import 'package:lottie/lottie.dart';

class KocekExpired extends StatelessWidget {
  const KocekExpired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var my = ThemeShortcut.of(context);
    return WillPopScope(
        onWillPop: () async {
          // You can't get back.
          return false;
        },
        child: Scaffold(
            backgroundColor: my.color.background,
            body: SafeArea(
                child: Padding(
                    padding: insetAll(padding),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/animation/locked.json',
                              repeat: false),
                          Text("\nSesi Berakhir\n",
                              style: my.text.labelMedium?.copyWith(
                                  color: my.color.primary.withOpacity(0.75),
                                  height: 0.5,
                                  fontSize: 30)),
                          Text(
                              "Sepertinya akunmu sedang dibuka diperangkat lain saat ini\n",
                              style: my.text.labelSmall?.copyWith(
                                  color: my.color.primary.withOpacity(0.5)),
                              textAlign: TextAlign.center),
                        ]))),
            bottomNavigationBar: CustomTextButton(
              text: "LOGOUT",
              onTap: () async {
                await KocekApi.removeToken();
                context.removeToNamed(route: Env.initialRoute);
              },
              textStyle: my.text.labelMedium
                  ?.copyWith(color: my.color.background, fontSize: 14),
              color: my.color.primary,
              margin: inset(padding, 0, padding, padding),
            )));
  }
}
