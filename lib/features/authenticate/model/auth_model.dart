class AuthModel {
  final String message;
  final String token;

  AuthModel({required this.message, required this.token});

  AuthModel.onDefault() : this(message: "", token: "");

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        message: json["message"] ?? "-", token: json['token'] ?? "-");
  }
}
