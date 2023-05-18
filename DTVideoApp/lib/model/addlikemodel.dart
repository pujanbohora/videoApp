import 'dart:convert';

Addlikemodel addlikemodelFromJson(String str) => Addlikemodel.fromJson(json.decode(str));

String addlikemodelToJson(Addlikemodel data) => json.encode(data.toJson());

class Addlikemodel {
    Addlikemodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    List<dynamic>? result;

    factory Addlikemodel.fromJson(Map<String, dynamic> json) => Addlikemodel(
        status: json["status"],
        message: json["message"],
        result: List<dynamic>.from(json["result"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x)),
    };
}
