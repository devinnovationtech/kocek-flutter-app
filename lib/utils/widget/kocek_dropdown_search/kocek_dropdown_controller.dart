part of 'kocek_dropdown_search.dart';

class KocekDropdownController extends ValueNotifier<int?> {
  KocekDropdownController([this._value]) : super(_value);
  int? _value;

  @override
  int? get value => _value;

  @override
  set value(int? newValue) {
    _value = (newValue == null || newValue < 0) ? null : newValue;
    notifyListeners();
  }

  bool isValid(int length) => value != null && value! >= 0 && value! < length;
}
