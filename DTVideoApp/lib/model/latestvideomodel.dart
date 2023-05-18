// To parse this JSON data, do
//
//     final latestvideomodel = latestvideomodelFromJson(jsonString);

import 'dart:convert';

Latestvideomodel latestvideomodelFromJson(String str) => Latestvideomodel.fromJson(json.decode(str));

String latestvideomodelToJson(Latestvideomodel data) => json.encode(data.toJson());

class Latestvideomodel {
    Latestvideomodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<Result>? result;

    factory Latestvideomodel.fromJson(Map<String, dynamic> json) => Latestvideomodel(
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
    DateTime? createdAt;
    DateTime? updatedAt;
    String? categoryName;
    String? categoryImage;
    String? artistName;
    String? artistImage;

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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        artistName: json["artist_name"],
        artistImage: json["artist_image"],
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "category_name": categoryName,
        "category_image": categoryImage,
        "artist_name": artistName,
        "artist_image": artistImage,
    };
}
