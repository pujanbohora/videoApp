// To parse this JSON data, do
//
//     final videobyidmodel = videobyidmodelFromJson(jsonString);

import 'dart:convert';

Videobyidmodel videobyidmodelFromJson(String str) =>
    Videobyidmodel.fromJson(json.decode(str));

String videobyidmodelToJson(Videobyidmodel data) => json.encode(data.toJson());

class Videobyidmodel {
  Videobyidmodel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory Videobyidmodel.fromJson(Map<String, dynamic> json) => Videobyidmodel(
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
    this.artistId,
    this.categoryId,
    this.name,
    this.description,
    this.videoType,
    this.url,
    this.image,
    this.vView,
    this.vLike,
    this.isFeature,
    this.isPaid,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.categoryImage,
    this.artistName,
    this.artistImage,
    this.avgRating,
    this.isLike,
    this.isBookmark,
    this.isFollow,
    this.totalFollowers,
    this.isSubscription,
  });

  String? id;
  String? artistId;
  String? categoryId;
  String? name;
  String? description;
  String? videoType;
  String? url;
  String? image;
  String? vView;
  String? vLike;
  String? isFeature;
  String? isPaid;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? categoryImage;
  String? artistName;
  String? artistImage;
  String? avgRating;
  int? isLike;
  int? isBookmark;
  int? isFollow;
  int? totalFollowers;
  int? isSubscription;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        artistId: json["artist_id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        videoType: json["video_type"],
        url: json["url"],
        image: json["image"],
        vView: json["v_view"],
        vLike: json["v_like"],
        isFeature: json["is_feature"],
        isPaid: json["is_paid"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        artistName: json["artist_name"],
        artistImage: json["artist_image"],
        avgRating: json["avg_rating"],
        isLike: json["is_like"],
        isBookmark: json["is_bookmark"],
        isFollow: json["is_follow"],
        totalFollowers: json["total_followers"],
        isSubscription: json["is_subscription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "artist_id": artistId,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "video_type": videoType,
        "url": url,
        "image": image,
        "v_view": vView,
        "v_like": vLike,
        "is_feature": isFeature,
        "is_paid": isPaid,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category_name": categoryName,
        "category_image": categoryImage,
        "artist_name": artistName,
        "artist_image": artistImage,
        "avg_rating": avgRating,
        "is_like": isLike,
        "is_bookmark": isBookmark,
        "is_follow": isFollow,
        "total_followers": totalFollowers,
        "is_subscription": isSubscription,
      };
}
