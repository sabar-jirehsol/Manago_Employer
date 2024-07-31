// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

EmployerDetailsModel employerDetailsModelFromJson(String str) =>
    EmployerDetailsModel.fromJson(json.decode(str));

String employerDetailsModelToJson(EmployerDetailsModel data) =>
    json.encode(data.toJson());

class EmployerDetailsModel {
  EmployerDetailsModel({
    this.message,
    this.data,
  });

  String? message;
  EmployerData? data;

  factory EmployerDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployerDetailsModel(
        message: json["message"],
        data: EmployerData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class EmployerData {
  EmployerData({
    this.isActive,
    this.isDeleted,
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.mobile,
    this.userId,
    this.v,
    this.gstnNo,
    this.address,
    this.annualTurnover,
    this.businessName,
    this.city,
    this.email,
    this.firmType,
    this.name,
    this.country,
    this.state,
    this.totalStaff,
    this.about,
    this.profilepic,
    this.dialcode,
    this.businessAddress,
    this.businessCountry,
    this.businessCity,
    this.businessEmail,
    this.businessFoundedDate,
    this.businessState,
    this.businessWebsite,
    this.category,
    this.description,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.other,
    this.pincode,
    this.twitter,
    this.firmSize,
  });

  bool? isActive;
  bool? isDeleted;
  String? id;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? mobile;
  String? userId;
  int? v;
  String? gstnNo;
  String? address;
  dynamic annualTurnover;
  String? businessName;
  String? country;
  String? city;
  String? email;
  String? firmType;
  String? name;
  String? state;
  int? totalStaff;
  String? about;
  String? businessAddress;
  String?businessCountry;
  String? businessCity;
  String? businessEmail;
  String? businessFoundedDate;
  String? businessState;
  String? businessWebsite;
  String? category;
  String? description;
  String? facebook;
  String? instagram;
  String? linkedin;
  String? other;
  String? pincode;
  String? twitter;
  String? firmSize;
  String? profilepic;
  String? dialcode;

  factory EmployerData.fromJson(Map<String, dynamic> json) => EmployerData(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        mobile: json["mobile"],
        userId: json["userId"],
        v: json["__v"],
        gstnNo: json["GSTNNo"],
        address: json["address"],
        profilepic: json['profilePic'],
        dialcode: json['dial_code']!=null?json['dial_code']:" ",
        annualTurnover: json["annualTurnover"],
        businessName: json["businessName"],
        country: json["country"],
        city: json["city"],
        email: json["email"],
        firmType: json["firmType"],
        name: json["name"],
        state: json["state"],
        totalStaff: json["totalStaff"],
        about: json["about"],
        businessAddress: json["businessAddress"],
        businessCountry: json["businessCountry"],
        businessCity: json["businessCity"],
        businessEmail: json["businessEmail"],
        businessFoundedDate: json["businessFoundedDate"],
        businessState: json["businessState"],
        businessWebsite: json["businessWebsite"],
        category: json["category"],
        description: json["description"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
        other: json["other"],
        pincode: json["pincode"],
        twitter: json["twitter"],
        firmSize: json["firmSize"],
      );

  Map<String, dynamic> toJson() => {
        "profilepic":profilepic,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "mobile": mobile,
        "userId": userId,
        "__v": v,
        "GSTNNo": gstnNo,
        "address": address,
        "annualTurnover": annualTurnover,
        "businessName": businessName,
    "country":country,
        "city": city,
        "email": email,
        "firmType": firmType,
        "name": name,
        "state": state,
        "dialcode":dialcode,
        "totalStaff": totalStaff,
        "about": about,
        "businessAddress": businessAddress,
        "businessCity": businessCity,
    "businessCountry":businessCountry,
        "businessEmail": businessEmail,
        "businessFoundedDate": businessFoundedDate,
        "businessState": businessState,
        "businessWebsite": businessWebsite,
        "category": category,
        "description": description,
        "facebook": facebook,
        "instagram": instagram,
        "linkedin": linkedin,
        "other": other,
        "pincode": pincode,
        "twitter": twitter,
        "firmSize": firmSize,
      };
}
