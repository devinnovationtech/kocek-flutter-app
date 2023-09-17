extension DateTimeParser on String? {
  DateTime? get toDate => this == null ? null : DateTime.parse(this!);
}

extension StripDateTime on DateTime? {
  String? toStripDate() {
    if (this == null) {
      return null;
    } else {
      return "${this!.year}-${this!.month}-${this!.day}";
    }
  }
}
