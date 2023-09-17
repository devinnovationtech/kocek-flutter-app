part of "../cubit/kocek_image_uploader_cubit.dart";

class KocekImageUploaderModel extends Equatable {
  const KocekImageUploaderModel(
      {required this.success, required this.message, required this.path});
  final bool success;
  final String message, path;

  factory KocekImageUploaderModel.fromJson(Map<String, dynamic> json) {
    return KocekImageUploaderModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "~",
        path: KocekApi.baseURL.replaceAll("api", json["file_path"] ?? "storage"));
  }

  const KocekImageUploaderModel.onDefault()
      : this(message: "", path: "", success: false);

  @override
  List<Object?> get props =>
      ["success: $success", "message: $message", "path: $path"];
}
