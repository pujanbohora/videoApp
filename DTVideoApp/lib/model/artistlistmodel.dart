import 'dart:convert';

Artistlistmodel artistlistmodelFromJson(String str) => Artistlistmodel.fromJson(json.decode(str));

String artistlistmodelToJson(Artistlistmodel data) => json.encode(data.toJson());

class Artistlistmodel {
    Artistlistmodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<Result>? result;

    factory Artistlistmodel.fromJson(Map<String, dynamic> json) => Artistlistmodel(
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
        this.bio,
        this.address,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    String? name;
    String? bio;
    String? address;
    String? image;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        address: json["address"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "address": address,
        "image": image,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
