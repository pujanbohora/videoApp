import 'dart:convert';

PackagesModel packagesModelFromJson(String str) =>
    PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  PackagesModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
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
    this.name,
    this.type,
    this.price,
    this.time,
    this.image,
    this.productPackage,
    this.status,
  });

  String? id;
  String? name;
  String? type;
  String? price;
  String? time;
  String? image;
  String? productPackage;
  String? status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        price: json["price"],
        time: json["time"],
        image: json["image"],
        productPackage: json["product_package"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "time": time,
        "image": image,
        "product_package": productPackage,
        "status": status,
      };
}
