// To parse this JSON data, do
//
//     final resendOtpModel = resendOtpModelFromJson(jsonString);

import 'dart:convert';

ResendOtpModel resendOtpModelFromJson(String str) =>
    ResendOtpModel.fromJson(json.decode(str));

String resendOtpModelToJson(ResendOtpModel data) => json.encode(data.toJson());

class ResendOtpModel {
  ResendOtpModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
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
    this.id,
    this.otp,
  });

  String? id;
  String? otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "otp": otp,
      };
}
