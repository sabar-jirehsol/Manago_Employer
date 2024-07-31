// To parse this JSON data, do
//
//     final otpVerificationModel = otpVerificationModelFromJson(jsonString);

import 'dart:convert';

OtpVerificationModel otpVerificationModelFromJson(String str) =>
    OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) =>
    json.encode(data.toJson());

class OtpVerificationModel {
  OtpVerificationModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      OtpVerificationModel(
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
    this.token,
    this.id,

  });


  String? id;
  String? token;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        token:json["token"]
      );

  Map<String, dynamic> toJson() => {
        "token":token,
         "_id": id,

      };
}
