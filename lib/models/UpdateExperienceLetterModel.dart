// To parse this JSON data, do
//
//     final deleteJobModel = deleteJobModelFromJson(jsonString);

import 'dart:convert';

UpdateExperienceLetterModel updateExperienceLetterModelFromJson(String str) =>
    UpdateExperienceLetterModel.fromJson(json.decode(str));

String updateExperienceModelToJson(UpdateExperienceLetterModel data) => json.encode(data.toJson());

class UpdateExperienceLetterModel {
  UpdateExperienceLetterModel({
    this.message,
    this.document,
  });

  String? message;
  Document? document;

  factory UpdateExperienceLetterModel.fromJson(Map<String, dynamic> json) => UpdateExperienceLetterModel(
    message: json["message"],
    document: Document.fromJson(json["document"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "jobs": document,
  };
}

class Document {
  Document({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
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
