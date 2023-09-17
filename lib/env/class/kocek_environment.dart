import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/features/authenticate/state/auth_cubit.dart';
import 'package:kocek_app/features/authenticate/state/login_cubit.dart';
import 'package:kocek_app/features/authenticate/widget/auth_page.dart';
import 'package:kocek_app/features/authenticate/widget/login_page.dart';
import 'package:kocek_app/features/authenticate/widget/otp_page.dart';
import 'package:kocek_app/features/onboarding/widget/onboarding_page.dart';
import 'package:kocek_app/features/profile/profile_name_page.dart';
import 'package:kocek_app/playground.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kocek_app/utils/static/constant_variable.dart';
import 'package:kocek_app/utils/widget/bug_catcher.dart';
import 'package:kocek_app/utils/widget/custom_camera_dialog.dart';

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kocek_app/env/model/kocek_date_model.dart';

part 'package:kocek_app/env/class/kocek_api.dart';
part 'package:kocek_app/env/class/kocek_asset.dart';
part 'package:kocek_app/env/class/kocek_function.dart';
part 'package:kocek_app/env/class/kocek_parse.dart';
part 'package:kocek_app/env/class/kocek_route.dart';
part 'package:kocek_app/env/enum/kocek_enum.dart';
part 'package:kocek_app/env/model/kocek_model.dart';

typedef Env = KocekEnvironment;

class KocekEnvironment {
  static Map<String, Widget Function(BuildContext)> routes = {
    for (KocekRoute route in [
      KocekRoute.playground,
      KocekRoute.auth,
      KocekRoute.loginOrRegister,
      KocekRoute.otp,
      KocekRoute.onboarding,
      KocekRoute.profileName
    ])
      route.path: (BuildContext context) => route.page
  };

  static String initialRoute = KocekRoute.auth.path;
  static String dummyRoute = KocekRoute.playground.path;

  /// It's a shortcut to change wether app running cubits on server using [KocekScope.external] or running dummy data with [KocekScope.internal].
  static KocekScope scope = KocekScope.external;
}
