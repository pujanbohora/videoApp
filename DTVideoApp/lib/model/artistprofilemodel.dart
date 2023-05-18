import 'dart:convert';

Artistprofilemodel artistprofilemodelFromJson(String str) =>
    Artistprofilemodel.fromJson(json.decode(str));

String artistprofilemodelToJson(Artistprofilemodel data) =>
    json.encode(data.toJson());

class Artistprofilemodel {
  Artistprofilemodel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  Result? result;

  factory Artistprofilemodel.fromJson(Map<String, dynamic> json) =>
      Artistprofilemodel(
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.bio,
    this.address,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isfollow,
    this.totalfollowers,
    this.totalVideo,
    this.totalView,
    this.totalLike,
  });

  String? id;
  String? name;
  String? bio;
  String? address;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? isfollow;
  int? totalfollowers;
  String? totalVideo;
  String? totalView;
  String? totalLike;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isfollow: json["is_follow"],
        totalfollowers: json["total_followers"],
        totalVideo: json["total_video"],
        totalView: json["total_view"],
        totalLike: json["total_like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "address": address,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_follow": isfollow,
        "total_followers": totalfollowers,
        "total_video": totalVideo,
        "total_view": totalView,
        "total_like": totalLike,
      };
}
