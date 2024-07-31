// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.message,
    this.data,


  });

  String? message;
  Data? data;




  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"]),

    message: json["message"],


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
    this.token,
    this.country,
    this.mobile,
    this.link
  });

  String? id;
  String? otp;
  String? token;
  String? country;
  String? mobile;
  String? link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    link: json['link'],
      id: json["_id"],
        otp: json["otp"],
        token: json["token"],
        country:json["country"],
        mobile: json["mobile"]
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "otp": otp,
        "token": token,
         "country":country,
        "mobile": mobile,
    "link":link
      };
}

