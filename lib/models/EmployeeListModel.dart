// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) =>
    EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) =>
    json.encode(data.toJson());

class EmployeeListModel {
  EmployeeListModel({
    this.message,
    this.data,
  });

  String? message;
  List<Employee>? data;

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) =>
      EmployeeListModel(
        message: json["message"],
        data: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Employee {
  Employee({
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.candidateId,
    this.offeredBasicSalary,
    this.designation,
    this.note,
    this.joiningDate,
    this.relivingDate,
    this.abscondededDate,
    this.workingDate,
    this.createdBy,
    this.modifiedBy,
    this.v,
  });
String? status;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  CandidateId? candidateId;
  String? offeredBasicSalary;
  String? designation;
  String? note;
  String? joiningDate;
  String?relivingDate;
  String?abscondededDate;
  String?workingDate;
  String? createdBy;
  String? modifiedBy;
  int? v;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
//TOdo check this below parts 15.3.24
    candidateId: CandidateId.fromJson(json["candidateID"]) ,
    offeredBasicSalary: json["OfferedBasicSalary"] ??   json["offeredSalary"].toString(),
    designation: json["Designation"]?? json["designation"],
    note: json["Note"],
    joiningDate: json["JoiningDate"]?? json['joiningDate'],
    relivingDate:json["relivingDate"],
    abscondededDate:json["abscondededDate"],
    workingDate:json["workingDate"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status":status,
    "createdAt": createdAt!.toIso8601String(),
    "modifiedAt": modifiedAt!.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "candidateID": candidateId!.toJson(),
    "OfferedBasicSalary": offeredBasicSalary,
    "Designation": designation,
    "Note": note,
    "JoiningDate": joiningDate,
    "relivingDate":relivingDate,
    "abscondededDate":abscondededDate,
    "workingDate":workingDate,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "__v": v,
  };
}

class CandidateId {
  CandidateId({
    this.personalInfo,
    this.id,
  });

  PersonalInfo? personalInfo;
  String? id;

  factory CandidateId.fromJson(Map<String, dynamic> json) => CandidateId(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo!.toJson(),
    "_id": id,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
    this.dialcode,
    this.mobile,
    this.email,
    this.address,
    this.state,
    this.city,
    this.pinCode,
    this.dob,
    this.maritalStatus,
    this.gender,
    this.aadhar,
    this.profilePic,
  });

  String? name;
  String?dialcode;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? city;
  int? pinCode;
  String? dob;
  String? maritalStatus;
  String? gender;
  String? aadhar;
  String? profilePic;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    dialcode: json["dial_code"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pinCode: json["pinCode"],
    dob: json["dob"],
    maritalStatus: json["maritialStatus"],
    gender: json["gender"], // Corrected from "Gender" to "gender"
    aadhar: json["Aadhar"],
      profilePic:json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "state": state,
    "city": city,
    "pinCode": pinCode,
    "dob": dob,
    "maritialStatus": maritalStatus, // Corrected from "maritalStatus" to "maritialStatus"
    "gender": gender, // Corrected from "Gender" to "gender"
    "Aadhar": aadhar,
  };
}
