// To parse this JSON data, do
//
//     final updateJobModel = updateJobModelFromJson(jsonString);

import 'dart:convert';

UpdateJobModel updateJobModelFromJson(String str) =>
    UpdateJobModel.fromJson(json.decode(str));

String updateJobModelToJson(UpdateJobModel data) => json.encode(data.toJson());

class UpdateJobModel {
  UpdateJobModel({
    this.message,
    this.jobs,
  });

  String? message;
  Jobs? jobs;

  factory UpdateJobModel.fromJson(Map<String, dynamic> json) => UpdateJobModel(
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
