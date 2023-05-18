import 'dart:convert';

Addfavouritemodel addfavouritemodelFromJson(String str) => Addfavouritemodel.fromJson(json.decode(str));

String addfavouritemodelToJson(Addfavouritemodel data) => json.encode(data.toJson());

class Addfavouritemodel {
    Addfavouritemodel({
        this.status,
        this.message,
        this.userId,
    });

    int? status;
    String? message;
    String? userId;

    factory Addfavouritemodel.fromJson(Map<String, dynamic> json) => Addfavouritemodel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_id": userId,
    };
}
