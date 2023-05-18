import 'dart:convert';

Chackfavouritemodel chackfavouritemodelFromJson(String str) => Chackfavouritemodel.fromJson(json.decode(str));

String chackfavouritemodelToJson(Chackfavouritemodel data) => json.encode(data.toJson());

class Chackfavouritemodel {
    Chackfavouritemodel({
        this.status,
        this.message,
        this.result,
    });

    int? status;
    String? message;
    String? result;

    factory Chackfavouritemodel.fromJson(Map<String, dynamic> json) => Chackfavouritemodel(
        status: json["status"],
        message: json["message"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result,
    };
}
