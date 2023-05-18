// To parse this JSON data, do
//
//     final albumnmodel = albumnmodelFromJson(jsonString);

import 'dart:convert';

Albumnmodel albumnmodelFromJson(String str) =>
    Albumnmodel.fromJson(json.decode(str));

String albumnmodelToJson(Albumnmodel data) => json.encode(data.toJson());

class Albumnmodel {
  Albumnmodel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory Albumnmodel.fromJson(Map<String, dynamic> json) => Albumnmodel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.videoIds,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? videoIds;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        videoIds: json["video_ids"],
        name: json["name"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_ids": videoIds,
        "name": name,
        "image": image,
        "created_at": createdAt!,
        "updated_at": updatedAt!,
      };
}
