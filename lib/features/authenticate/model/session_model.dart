import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionModel {
  final SharedPreferences preference;
  final PackageInfo package;

  SessionModel({required this.preference, required this.package});

  @override
  toString() => "SessionModel(preference: $preference, package: $package)";
}
