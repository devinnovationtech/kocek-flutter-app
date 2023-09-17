part of 'package:kocek_app/env/class/kocek_environment.dart';

class KocekParse {

  static String intToCurrency(int value) {
    return "Rp " + NumberFormat('#,##0', 'id_ID').format(value);
  }

  static int currencyToInt(String value) {
    return int.tryParse(value.replaceAll(RegExp(r'[A-Za-z\.\s]'), '')) ?? 0;
  }

  static String formatSize(File file, {required KocekFileSize size}) {
    double digit = file.lengthSync() / [100, 1000, 10000][size.index];
    String satuan = digit.toString().split(".").first;
    String decimal =
        digit.toString().split(".").last.padRight(2, "0").substring(0, 2);
    return "$satuan.$decimal " + size.name.toUpperCase();
  }

  static String formatTime(TimeOfDay time, {required String format}) {
/*    String result = format
      ..replaceAll(RegExp(r'!hour'), watch.hour.toString().padLeft(2, "0"))
      ..replaceAll(RegExp(r'!minute'), watch.minute.toString().padLeft(2, "0"));*/

    var hour = time.hour.toString().padLeft(2, "0");
    var minute = time.minute.toString().padLeft(2, "0");
    return "$hour:$minute";
  }

  static String formatDate(DateTime time,
      {required String Function(KocekDateModel value) format}) {
    return format(KocekDateModel.fromDate(time));
  }

  static bool validateEmail(String value) =>
      value.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'));
}

class KocekCurrencyTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = KocekParse.intToCurrency(KocekParse.currencyToInt(newValue.text));
    return TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

class KocekAbsoluteInteger extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = (int.tryParse(newValue.text) ?? 0).abs().toString();
    return TextEditingValue(
        text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}
