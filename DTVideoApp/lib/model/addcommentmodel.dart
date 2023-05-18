// To parse this JSON data, do
//
//     final addcommentmodel = addcommentmodelFromJson(jsonString);

import 'dart:convert';

Addcommentmodel addcommentmodelFromJson(String str) => Addcommentmodel.fromJson(json.decode(str));

String addcommentmodelToJson(Addcommentmodel data) => json.encode(data.toJson());

class Addcommentmodel {
    Addcommentmodel({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory Addcommentmodel.fromJson(Map<String, dynamic> json) => Addcommentmodel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
