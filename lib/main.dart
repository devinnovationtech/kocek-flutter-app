import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/env/themes/kocek_theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://b7f5b30625f5eabcf8033ff1d870dacf@o4504400277078017.ingest.sentry.io/4505879107272704';
      options.enableAutoPerformanceTracing = true;
      options.tracesSampleRate = 1.0;
      options.tracesSampler = (samplingContext) {
        return 1.0;
      };
    },
    appRunner: () async => runApp(MaterialApp(
        title: KocekAsset.app_label,
        debugShowCheckedModeBanner: false,
        color: const Color(0xFF163A90),
        theme: await kocekTheme(),
        routes: Env.routes,
        initialRoute: Env.initialRoute)),
  );
}
