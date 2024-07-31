// To parse this JSON data, do
//
//     final deleteJobModel = deleteJobModelFromJson(jsonString);

import 'dart:convert';

DeleteJobModel deleteJobModelFromJson(String str) =>
    DeleteJobModel.fromJson(json.decode(str));

String deleteJobModelToJson(DeleteJobModel data) => json.encode(data.toJson());

class DeleteJobModel {
  DeleteJobModel({
    this.message,
    this.jobs,
  });

  String? message;
  Jobs? jobs;

  factory DeleteJobModel.fromJson(Map<String, dynamic> json) => DeleteJobModel(
        message: json["message"],
        jobs: Jobs.fromJson(json["jobs"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "jobs": jobs,
      };
}

class Jobs {
  Jobs({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
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
