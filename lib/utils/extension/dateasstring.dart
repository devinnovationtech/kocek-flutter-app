import 'package:kocek_app/utils/static/days.dart';
import 'package:kocek_app/utils/static/months.dart';

extension DateAsNullableString on DateTime? {
  String? asNullableString({bool dateOnly = false}) {
    if (this != null) {
      if (dateOnly == false) {
        return "${days[this!.weekday - 1]} ${this!.day} ${months[this!.month]} ${this!.year} ${this!.hour}:${this!.minute}";
      } else {
        return "${this!.day} ${months[this!.month]} ${this!.year}";
      }
    } else {
      return null;
    }
  }
}

extension DateAsString on DateTime {
  String get kePenanggalan {
    try {
      return '$day ${months[month]} $year pukul ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return toString();
    }
  }

  String beString({bool date = true, bool month = true, bool year = true}) {
    return "${date ? days[weekday - 1] + " " : ""}${month ? '$day ${months[this.month]} ${this.year} ' : ""}${year ? '$hour:$minute' : ''}";
  }

  String asString({bool dateOnly = false, bool shrinkmonth = false}) {
    try {
      if (dateOnly == false) {
        return "${days[weekday - 1]} $day ${shrinkmonth ? shortmonths[month] : months[month]} $year $hour:$minute";
      } else {
        return "$day ${shrinkmonth ? shortmonths[month] : months[month]} $year";
      }
    } catch (e) {
      return toString();
    }
  }

  List<String> asListString({required String code}) {
    return [
      " ${days[weekday - 1]} $day ${months[month]} $year ",
      code,
      " $hour:$minute"
    ];
  }

  String asSlashString() {
    return "$day/$month/$year $hour:$minute WIB";
  }

  String asStripString() {
    return "$year-$month-$day";
  }

  /// Only Date, Month & Year.
  ///
  /// ```dart
  /// String time = DateTime.now().onlyDMY;
  /// print(time) // "20/6/2022"
  /// ```
  String get onlyDMY => '$day/$month/$year';

  /// Only Month & Year.
  ///
  /// ```dart
  /// String time = DateTime.now().onlyMY;
  /// print(time) // "6/2022"
  /// ```
  String get onlyMY => '$month/$year';
}

extension DurationParse on Duration {
  String get asTimer {
    try {
      List<String> values = toString().split(".").first.split(":");
      if (int.parse(values[0]).abs() >= 24) {
        return "${(int.parse(values[0]) ~/ 24).abs()} Hari yg lalu";
      } else {
        int jam = int.tryParse(values[0]) ?? 0;
        int menit = int.tryParse(values[1]) ?? 0;
        return "${jam <= 0 ? "" : jam.toString() + " Jam "}${menit <= 0 ? "" : menit.toString() + " Menit "}${values[2]} Detik yg lalu";
      }
    } catch (e) {
      return "-";
    }
  }

  String get asCountdown {
    try {
      List<String> values = toString().split(".").first.split(":");
      if (int.parse(values[0]).abs() >= 24) {
        return "${(int.parse(values[0]) ~/ 24).abs()} Hari ${int.parse(values[0]) < 0 ? "yg Lalu" : "Lagi"}";
      } else {
        int jam = int.tryParse(values[0]) ?? 0;
        int menit = int.tryParse(values[1]) ?? 0;
        return "${jam <= 0 ? "" : jam.toString() + " Jam "}${menit <= 0 ? "" : menit.toString() + " Menit "}${values[2]} Detik ${int.parse(values[0]) < 0 ? "yg Lalu" : "Lagi"}";
      }
    } catch (e) {
      return "-";
    }
  }
}

DateTime? parseDate(String? value) {
  if (value == null) {
    return null;
  } else {
    try {
      return DateTime.parse(value.toString());
    } catch (e) {
      return null;
    }
  }
}
