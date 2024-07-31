import 'dart:convert';

LoginForgotOtpModel loginForgotOtpModelFromJson(String str) =>
    LoginForgotOtpModel.fromJson(json.decode(str));

String loginModelToJson(LoginForgotOtpModel data) => json.encode(data.toJson());

class LoginForgotOtpModel {
  LoginForgotOtpModel({
    this.message,

  });

  String? message;


  factory LoginForgotOtpModel.fromJson(Map<String, dynamic> json) => LoginForgotOtpModel(
     message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,

  };
}
