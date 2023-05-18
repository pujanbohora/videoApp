import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.result,
    this.message,
  });

  int? status;
  List<Result>? result;
  String? message;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        status: json["status"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
      };
}

class Result {
  Result({
    this.id,
    this.appId,
    this.includedSegments,
    this.data,
    this.headings,
    this.contents,
    this.bigPicture,
    this.createdAt,
  });

  String? id;
  String? appId;
  String? includedSegments;
  String? data;
  String? headings;
  String? contents;
  String? bigPicture;
  String? createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        appId: json["app_id"],
        includedSegments: json["included_segments"],
        data: json["data"],
        headings: json["headings"],
        contents: json["contents"],
        bigPicture: json["big_picture"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_id": appId,
        "included_segments": includedSegments,
        "data": data,
        "headings": headings,
        "contents": contents,
        "big_picture": bigPicture,
        "created_at": createdAt,
      };
}
