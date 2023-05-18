import 'dart:convert';

Generalsettingmodel generalsettingmodelFromJson(String str) =>
    Generalsettingmodel.fromJson(json.decode(str));

String generalsettingmodelToJson(Generalsettingmodel data) =>
    json.encode(data.toJson());

class Generalsettingmodel {
  Generalsettingmodel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory Generalsettingmodel.fromJson(Map<String, dynamic> json) =>
      Generalsettingmodel(
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
    this.key,
    this.value,
  });

  String? id;
  String? key;
  String? value;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}
