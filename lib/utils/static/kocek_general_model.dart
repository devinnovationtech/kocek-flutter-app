import 'package:equatable/equatable.dart';

class KocekGeneralModel extends Equatable {
  const KocekGeneralModel({required this.success, required this.message});
  final bool success;
  final String message;

  factory KocekGeneralModel.fromJson(Map<String, dynamic> json) =>
      KocekGeneralModel(
          success: json["success"] ?? json["status"] ?? false,
          message: json["message"] ?? "");

  @override
  List<Object?> get props => ["success: $success", "message: $message"];
}
