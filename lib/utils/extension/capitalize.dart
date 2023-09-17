extension Capitalize on String {
  String toCaps() {
    return replaceAllMapped(RegExp(r'^[A-Za-z]|(?<=[\s]).'),
        (match) => match.group(match.groupCount)?.toUpperCase() ?? "");
  }
}
