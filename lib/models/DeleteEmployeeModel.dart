// To parse this JSON data, do
//
//     final employeeDeleteModel = employeeDeleteModelFromJson(jsonString);

import 'dart:convert';

EmployeeDeleteModel employeeDeleteModelFromJson(String str) =>
    EmployeeDeleteModel.fromJson(json.decode(str));

String employeeDeleteModelToJson(EmployeeDeleteModel data) =>
    json.encode(data.toJson());

class EmployeeDeleteModel {
  EmployeeDeleteModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory EmployeeDeleteModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class Data {
  Data({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ok: json["ok"],
        nModified: json["nModified"],
        n: json["n"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "nModified": nModified,
        "n": n,
      };
}
