part of '../class/kocek_environment.dart';

class KocekModel extends Equatable {
  const KocekModel({required this.status, required this.message});
  final bool status;
  final String message;

  factory KocekModel.fromJson(Map<String, dynamic> json) {
    var message = json["message"];
    return KocekModel(
        status: json["status"]?.toString().toUpperCase() == "SUCCESS" ||
            json["status"] == true ||
            json["success"] == true,
        message: message is List ? message.join("\n") : message ?? "");
  }

  const KocekModel.onDefault() : this(message: "~", status: false);

  @override
  List<Object?> get props => ["status: $status", "message: $message"];
}

class KocekReportModel extends Equatable {
  const KocekReportModel(
      {required this.api,
      required this.title,
      required this.content,
      required this.message,
      required this.version,
      required this.datetime,
      required this.type});
  final String api, title, content, message, version, datetime;
  final KocekAPIType type;

  static Future<KocekReportModel> onDefault(
      {required List<String> api,
      required String title,
      required String content,
      required KocekAPIType type}) async {
    Future<String> version() async {
      try {
        var info = await PackageInfo.fromPlatform();
        return "${KocekAsset.app_label} v${info.version}";
      } catch (e) {
        return "";
      }
    }

    return KocekReportModel(
        type: type,
        api: api.map((e) => KocekApi.baseURL + e).join(","),
        title: title,
        content: content,
        message: KocekApi.parse(content),
        version: await version(),
        datetime: KocekParse.formatDate(DateTime.now(),
            format: (x) =>
                "${x.date} ${x.month} ${x.year}, Pukul ${x.hour}:${x.minute}"));
  }

  Map<String, dynamic> toJson() {
    return {
      "api": api,
      "title": title,
      "content": content,
      "message": message,
      "version": version,
      "datetime": datetime,
      "type": type.name.toUpperCase()
    };
  }

  @override
  List<Object?> get props => [
        "api: $api",
        "title: $title",
        "content: $content",
        "message: $message",
        "version: $version",
        "datetime: $datetime",
        "type: $type"
      ];
}
