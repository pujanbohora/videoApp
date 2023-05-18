// To parse this JSON data, do
//
//     final viewcommentmodel = viewcommentmodelFromJson(jsonString);

import 'dart:convert';

Viewcommentmodel viewcommentmodelFromJson(String str) => Viewcommentmodel.fromJson(json.decode(str));

String viewcommentmodelToJson(Viewcommentmodel data) => json.encode(data.toJson());

class Viewcommentmodel {
    Viewcommentmodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<Result>? result;

    factory Viewcommentmodel.fromJson(Map<String, dynamic> json) => Viewcommentmodel(
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
        this.fullname,
        this.image,
        this.id,
        this.videoId,
        this.comment,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? fullname;
    String? image;
    String? id;
    String? videoId;
    String? comment;
    String? userId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        fullname: json["fullname"],
        image: json["image"],
        id: json["id"],
        videoId: json["video_id"],
        comment: json["comment"],
        userId: json["user_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "image": image,
        "id": id,
        "video_id": videoId,
        "comment": comment,
        "user_id": userId,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
