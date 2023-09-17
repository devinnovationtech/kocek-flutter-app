import 'package:equatable/equatable.dart';

class ModelExtender extends Equatable {
  Value to<Value extends Object>(String description, Value value) {
    try {
      return value;
    } catch (e) {
      throw Exception("$runtimeType($description: $value)");
    }
  }

  @override
  List<Object?> get props => [];
}
