// To parse this JSON data, do
//
//     final employerUpdateModel = employerUpdateModelFromJson(jsonString);

import 'dart:convert';

EmployerUpdateModel employerUpdateModelFromJson(String str) =>
    EmployerUpdateModel.fromJson(json.decode(str));

String employerUpdateModelToJson(EmployerUpdateModel data) =>
    json.encode(data.toJson());

class EmployerUpdateModel {
  EmployerUpdateModel({
    this.message,
    this.employer,
  });

  String? message;
  Employer? employer;

  factory EmployerUpdateModel.fromJson(Map<String, dynamic> json) =>
      EmployerUpdateModel(
        message: json["message"],
        employer: Employer.fromJson(json["employer"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employer": employer,
      };
}

class Employer {
  Employer({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    n: json["n"],
    nModified: json["nModified"],
    ok: json["ok"],
      );

  Map<String, dynamic> toJson() => {
         "n": n,
         "nModified": nModified,
         "ok": ok,
      };
}
