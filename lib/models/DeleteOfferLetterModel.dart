// To parse this JSON data, do
//
//     final deleteJobModel = deleteJobModelFromJson(jsonString);

import 'dart:convert';

  DeleteOfferLetterModel deleteOfferLetterModelFromJson(String str) =>
    DeleteOfferLetterModel.fromJson(json.decode(str));

String deleteOfferLetterModelToJson(DeleteOfferLetterModel data) => json.encode(data.toJson());

class DeleteOfferLetterModel {
  DeleteOfferLetterModel({
    this.message,
    this.data,
  }){
    print("Delete offerletter and experience  model values");
    print(data);}

  String? message;
  Data? data;

  factory DeleteOfferLetterModel.fromJson(Map<String, dynamic> json) => DeleteOfferLetterModel(
    message: json["message"],
    data: Data.fromJson(json["data"]??json['document']),
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
