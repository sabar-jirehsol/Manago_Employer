// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

 stateCityViaPincodeModel stateCityViaPincodeModelFromJson(String str) =>
    stateCityViaPincodeModel.fromJson(json.decode(str));

String employerDetailsModelToJson(stateCityViaPincodeModel data) =>
    json.encode(data.toJson());

class stateCityViaPincodeModel {
  stateCityViaPincodeModel({
    this.message,
    this.data,
  });

  String? message;
  List<PincodeData>? data;

  factory stateCityViaPincodeModel.fromJson(Map<String, dynamic> json) =>
      stateCityViaPincodeModel(
        message: json["message"],
        data: List<PincodeData>.from(json["data"].map((x) => PincodeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PincodeData {
  PincodeData({
    this.id,
    this.pincode,
    this.divisionName,
    this.regionName,
    this.taluk,
    this.districtName,
    this.stateName,
    this.country,
    this.v,
  });

  String? id;
  String? pincode;
  String? divisionName;
  String? regionName;
  String? taluk;
  String? districtName;
  String? stateName;
  String? country;
  int? v;

  factory PincodeData.fromJson(Map<String, dynamic> json) => PincodeData(
    id: json["_id"],
    pincode: json["pincode"].toString(), // Pincode might be better as a string to handle leading zeros
    divisionName: json["divisionName"],
    regionName: json["regionName"],
    taluk: json["taluk"],
    districtName: json['districtName'],
    stateName: json["stateName"],
    country: json["country"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "pincode": pincode,
    "divisionName": divisionName,
    "regionName": regionName,
    "taluk": taluk,
    "districtName": districtName,
    "stateName": stateName,
    "country": country,
    "__v": v,
  };
}

