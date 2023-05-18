// To parse this JSON data, do
//
//     final categorylistmodel = categorylistmodelFromJson(jsonString);

import 'dart:convert';

Categorylistmodel categorylistmodelFromJson(String str) => Categorylistmodel.fromJson(json.decode(str));

String categorylistmodelToJson(Categorylistmodel data) => json.encode(data.toJson());

class Categorylistmodel {
    Categorylistmodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<Result>? result;

    factory Categorylistmodel.fromJson(Map<String, dynamic> json) => Categorylistmodel(
        status: json["status"],
        message: json["message"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
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
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? name;
    String? image;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
