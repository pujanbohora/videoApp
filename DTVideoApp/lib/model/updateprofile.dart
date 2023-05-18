import 'dart:convert';

Updateprofilemodel updateprofilemodelFromJson(String str) => Updateprofilemodel.fromJson(json.decode(str));

String updateprofilemodelToJson(Updateprofilemodel data) => json.encode(data.toJson());

class Updateprofilemodel {
    Updateprofilemodel({
        this.status,
        this.message,
        this.id,
    });

    int? status;
    String? message;
    String? id;

    factory Updateprofilemodel.fromJson(Map<String, dynamic> json) => Updateprofilemodel(
        status: json["status"],
        message: json["message"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
    };
}
