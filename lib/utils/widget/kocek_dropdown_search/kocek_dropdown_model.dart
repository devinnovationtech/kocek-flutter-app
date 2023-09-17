part of 'kocek_dropdown_search.dart';

class KocekDropdownModel extends Equatable {
  const KocekDropdownModel(
      {required this.index, required this.text, String? code})
      : code = code ?? "$index";
  final int index;
  final String code;
  final String text;

  @override
  List<Object?> get props => ["index: $index", "text: $text", "code: $code"];
}
