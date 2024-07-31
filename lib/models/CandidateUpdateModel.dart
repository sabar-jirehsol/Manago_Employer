// To parse this JSON data, do
//
//     final candidateUpdateModel = candidateUpdateModelFromJson(jsonString);

import 'dart:convert';

CandidateUpdateModel candidateUpdateModelFromJson(String str) =>
    CandidateUpdateModel.fromJson(json.decode(str));

String candidateUpdateModelToJson(CandidateUpdateModel data) =>
    json.encode(data.toJson());

class CandidateUpdateModel {
  CandidateUpdateModel({
    this.message,
    this.resp,
  });

  String? message;
  Resp? resp;

  factory CandidateUpdateModel.fromJson(Map<String, dynamic> json) =>
      CandidateUpdateModel(
        message: json["message"],
        resp: Resp.fromJson(json["resp"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "resp": resp,
      };
}

class Resp {
  Resp({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Resp.fromJson(Map<String, dynamic> json) => Resp(
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
