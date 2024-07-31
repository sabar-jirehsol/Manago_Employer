// To parse this JSON data, do
//
//     final updateSalaryModel = updateSalaryModelFromJson(jsonString);

import 'dart:convert';

UpdateSalaryModel updateSalaryModelFromJson(String str) =>
    UpdateSalaryModel.fromJson(json.decode(str));

String updateSalaryModelToJson(UpdateSalaryModel data) =>
    json.encode(data.toJson());

class UpdateSalaryModel {
  UpdateSalaryModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory UpdateSalaryModel.fromJson(Map<String, dynamic> json) =>
      UpdateSalaryModel(
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
