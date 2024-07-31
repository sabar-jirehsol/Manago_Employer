// To parse this JSON data, do
//
//     final searchJobModel = searchJobModelFromJson(jsonString);

import 'dart:convert';

SearchJobModel searchJobModelFromJson(String str) =>
    SearchJobModel.fromJson(json.decode(str));

String searchJobModelToJson(SearchJobModel data) => json.encode(data.toJson());

class SearchJobModel {
  SearchJobModel({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory SearchJobModel.fromJson(Map<String, dynamic> json) => SearchJobModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.keyskills,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.jobTitle,
    this.designation,
    this.experience,
    this.salary,
    this.vaccancy,
    this.description,
    this.employerId,
    this.v,
    this.candidateId,
  });

  List<String>? keyskills;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? jobTitle;
  String? designation;
  String? experience;
  int? salary;
  int? vaccancy;
  String? description;
  EmployerId? employerId;
  int? v;
  String? candidateId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        keyskills: List<String>.from(json["keyskills"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        jobTitle: json["jobTitle"],
        designation: json["designation"],
        experience: json["experience"],
        salary: json["salary"],
        vaccancy: json["vaccancy"],
        description: json["description"],
        employerId: json["employerID"] == null
            ? null
            : EmployerId.fromJson(json["employerID"]),
        v: json["__v"],
        candidateId: json["candidateID"] == null ? null : json["candidateID"],
      );

  Map<String, dynamic> toJson() => {
        "keyskills": List<dynamic>.from(keyskills!.map((x) => x)),
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "jobTitle": jobTitle,
        "designation": designation,
        "experience": experience,
        "salary": salary,
        "vaccancy": vaccancy,
        "description": description,
        "employerID": employerId == null ? null : employerId,
        "__v": v,
        "candidateID": candidateId == null ? null : candidateId,
      };
}

class EmployerId {
  EmployerId({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.name,
    this.businessName,
    this.firmType,
    this.mobile,
    this.email,
    this.address,
    this.state,
    this.panNo,
    this.gstnNo,
    this.totalStaff,
    this.annualTurnover,
    this.userId,
    this.v,
    this.city,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? name;
  String? businessName;
  String? firmType;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? panNo;
  String? gstnNo;
  int? totalStaff;
  String? annualTurnover;
  String? userId;
  int? v;
  String? city;

  factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        name: json["name"],
        businessName: json["businessName"],
        firmType: json["firmType"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        state: json["state"],
        panNo: json["panNo"] == null ? null : json["panNo"],
        gstnNo: json["GSTNNo"],
        totalStaff: json["totalStaff"],
        annualTurnover: json["annualTurnover"],
        userId: json["userId"],
        v: json["__v"],
        city: json["city"] == null ? null : json["city"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "name": name,
        "businessName": businessName,
        "firmType": firmType,
        "mobile": mobile,
        "email": email,
        "address": address,
        "state": state,
        "panNo": panNo == null ? null : panNo,
        "GSTNNo": gstnNo,
        "totalStaff": totalStaff,
        "annualTurnover": annualTurnover,
        "userId": userId,
        "__v": v,
        "city": city == null ? null : city,
      };
}
