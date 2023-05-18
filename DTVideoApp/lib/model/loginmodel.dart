class Loginmodel {
  Loginmodel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
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
    this.roleId,
    this.fullname,
    this.image,
    this.backgroundImage,
    this.email,
    this.password,
    this.authToken,
    this.mobile,
    this.type,
    this.status,
  });

  String? id;
  String? roleId;
  String? fullname;
  String? image;
  String? backgroundImage;
  String? email;
  String? password;
  String? authToken;
  String? mobile;
  String? type;
  String? status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        roleId: json["role_id"],
        fullname: json["fullname"],
        image: json["image"],
        backgroundImage: json["background_image"],
        email: json["email"],
        password: json["password"],
        authToken: json["auth_token"],
        mobile: json["mobile"],
        type: json["type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "fullname": fullname,
        "image": image,
        "background_image": backgroundImage,
        "email": email,
        "password": password,
        "auth_token": authToken,
        "mobile": mobile,
        "type": type,
        "status": status,
      };
}
