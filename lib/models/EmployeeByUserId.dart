// To parse this JSON data, do
//
//     final employeeByUserId = employeeByUserIdFromJson(jsonString);

import 'dart:convert';

EmployeeByUserId employeeByUserIdFromJson(String str) =>
    EmployeeByUserId.fromJson(json.decode(str));

String employeeByUserIdToJson(EmployeeByUserId data) =>
    json.encode(data.toJson());

class EmployeeByUserId {
  EmployeeByUserId({
    this.data,
  });

  Data? data;

  factory EmployeeByUserId.fromJson(Map<String, dynamic> json) =>
      EmployeeByUserId(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

class Data {
  Data({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.mobile,
    this.userId,
    this.v,
    this.email,
    this.firmType,
    this.name,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? mobile;
  String? userId;
  int? v;
  String? email;
  String? firmType;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        mobile: json["mobile"],
        userId: json["userId"],
        v: json["__v"],
        email: json["email"],
        firmType: json["firmType"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "mobile": mobile,
        "userId": userId,
        "__v": v,
        "email": email,
        "firmType": firmType,
        "name": name,
      };
}
