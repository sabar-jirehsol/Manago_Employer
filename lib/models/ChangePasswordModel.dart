import 'dart:convert';

changesetPasswordsModel changenewPasswordFromJson(String str) =>
    changesetPasswordsModel.fromJson(json.decode(str));

String changenewPasswordToJson(changesetPasswordsModel data) =>
    json.encode(data.toJson());

class changesetPasswordsModel {
  changesetPasswordsModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory changesetPasswordsModel.fromJson(Map<String, dynamic> json) =>
      changesetPasswordsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.skillSet,
    this.image,
    this.isMobileVerified,
    this.isEmailVerified,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.role,
    this.id,
    this.mobile,
    this.email,
    this.userRole,
    this.password,
    this.v,
    this.otp,
  });

  List<dynamic>? skillSet;
  String? image;
  bool? isMobileVerified;
  bool? isEmailVerified;
  String? createdAt;
  String? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? role;
  String? id;
  String? mobile;
  String? email;
  String? userRole;
  String? password;
  int? v;
  String? otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    skillSet: json["skillSet"] != null
        ? List<dynamic>.from(json["skillSet"])
        : [],
    image: json["image"],
    isMobileVerified: json["isMobileVerified"],
    isEmailVerified: json["isEmailVerified"],
    createdAt: json["createdAt"],
    modifiedAt: json["modifiedAt"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    role: json["role"],
    id: json["_id"],
    mobile: json["mobile"],
    email: json["email"],
    userRole: json["userRole"],
    password: json["password"],
    v: json["__v"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "skillSet": skillSet,
    "image": image,
    "isMobileVerified": isMobileVerified,
    "isEmailVerified": isEmailVerified,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "role": role,
    "_id": id,
    "mobile": mobile,
    "email": email,
    "userRole": userRole,
    "password": password,
    "__v": v,
    "otp": otp,
  };
}
