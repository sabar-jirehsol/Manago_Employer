// To parse this JSON data, do
//
//     final deleteJobModel = deleteJobModelFromJson(jsonString);

import 'dart:convert';

  UpdateOfferLetterModel updateOfferLetterModelFromJson(String str) =>
    UpdateOfferLetterModel.fromJson(json.decode(str));

String updateJobModelToJson(UpdateOfferLetterModel data) => json.encode(data.toJson());

class UpdateOfferLetterModel {
  UpdateOfferLetterModel({
    this.message,
    this.document,
  });

  String? message;
  Document? document;

  factory UpdateOfferLetterModel.fromJson(Map<String, dynamic> json) => UpdateOfferLetterModel(
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
