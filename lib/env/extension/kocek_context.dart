import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/static/shortcut_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/kocek_confirmation_dialogue.dart';
import 'package:kocek_app/utils/widget/theme_shortcut.dart';

extension KocekContext on BuildContext {
  Future<T?> to<T extends Object?>({required Widget child}) {
    try {
      return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => child));
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Halaman",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> toNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamed<T>(this, route, arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Rute $route",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> openTo<T extends Object?>(
      {required Widget child, Color color = Colors.black54}) {
    try {
      return showDialog(
          context: this, barrierColor: color, builder: (_) => child);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Popup",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> buildTo<T extends Object?>(
      {required Widget Function(BuildContext context) builder}) {
    try {
      return Navigator.push<T>(this, MaterialPageRoute(builder: builder));
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Halaman",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> sheetTo<T extends Object?>(
      {required Widget child, BoxConstraints? constraints}) {
    try {
      return showModalBottomSheet<T>(
          context: this,
          builder: (_) => child,
          constraints: constraints,
          isScrollControlled: true);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Membuka Bottom Sheet",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> removeTo<T extends Object?>({required Widget child}) {
    try {
      return Navigator.pushAndRemoveUntil(this,
          MaterialPageRoute(builder: (context) => child), (route) => false);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Pindah Halaman",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  Future<T?> removeToNamed<T extends Object?>(
      {required String route, Object? arguments}) {
    try {
      return Navigator.pushNamedAndRemoveUntil(this, route, (route) => false,
          arguments: arguments);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Pindah ke Rute $route",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  void close<T extends Object?>([T? result]) {
    try {
      return Navigator.pop<T>(this, result);
    } catch (e) {
      throw BugSheet(
              title: "Gagal Menutup Halaman",
              content: "$e",
              pagePath: "env/extension/kocek_context.dart",
              statePath: "-")
          .openWith(this);
    }
  }

  T? modal<T extends Object?>() =>
      ModalRoute.of(this)?.settings.arguments as T?;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> alert(
      {required String label,
      Color? color,
      Duration? duration,
      EdgeInsetsGeometry? margin}) {
    var my = ThemeShortcut.of(this);
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(circular(radius))),
        margin: margin ?? insetOn(left: 20, bottom: 20, right: 20),
        elevation: 2,
        content: Row(children: [
          Icon(Icons.info_outline, color: my.color.background),
          const SizedBox(width: 8),
          Expanded(
              child: Text(label.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 10.0)))
        ]),
        backgroundColor: color ?? my.color.error.withOpacity(0.925),
        duration: duration ?? alertDuration));
  }

  Future<bool> systemClose() async {
    bool? result = await openTo(
        color: ThemeShortcut.of(this).color.onBackground.withOpacity(0.85),
        child: Center(
            child: KocekConfirmationDialogue(
                label: "Peringatan",
                content: "Yakin Ingin Menutup Aplikasi?",
                onCancelTap: () => close(false),
                onNextTap: () => close(true))));

    if (result == true) {
      SystemNavigator.pop();
      return true;
    } else {
      return false;
    }
  }
}
