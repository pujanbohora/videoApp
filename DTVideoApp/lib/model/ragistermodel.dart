import 'dart:convert';

Registrationmodel registrationmodelFromJson(String str) => Registrationmodel.fromJson(json.decode(str));

String registrationmodelToJson(Registrationmodel data) => json.encode(data.toJson());

class Registrationmodel {
    Registrationmodel({
        this.status,
        this.message,
        this.id,
    });

    int? status;
    String? message;
    String? id;

    factory Registrationmodel.fromJson(Map<String, dynamic> json) => Registrationmodel(
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
 