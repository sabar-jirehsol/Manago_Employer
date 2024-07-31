// To parse this JSON data, do
//
//     final addEmployeeModel = addEmployeeModelFromJson(jsonString);

import 'dart:convert';

AddEmployeeModel addEmployeeModelFromJson(String str) =>
    AddEmployeeModel.fromJson(json.decode(str));

String addEmployeeModelToJson(AddEmployeeModel data) =>
    json.encode(data.toJson());

class AddEmployeeModel {
  AddEmployeeModel({
    this.message,
    this.data,
  });

  String? message;
  CandidataData? data;

  factory AddEmployeeModel.fromJson(Map<String, dynamic> json) =>
      AddEmployeeModel(
        message: json["message"],
        data: CandidataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class CandidataData {
  CandidataData({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.jobId,
    this.candidateId,
    this.employerId,
    this.offeredBasicSalary,
    this.offeredGrossSalary,
    this.designation,
    this.note,
    this.joiningDate,
    this.createdBy,
    this.modifiedBy,
    this.v,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? jobId;
  String? candidateId;
  String? employerId;
  String? offeredBasicSalary;
  String? offeredGrossSalary;
  String? designation;
  String? note;
  String? joiningDate;
  String? createdBy;
  String? modifiedBy;
  int? v;

  factory CandidataData.fromJson(Map<String, dynamic> json) => CandidataData(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        jobId: json["jobID"],
        candidateId: json["candidateID"],
        employerId: json["employerID"],
        offeredBasicSalary: json["OfferedBasicSalary"],
        offeredGrossSalary: json["OfferedGrossSalary"],
        designation: json["Designation"],
        note: json["Note"],
        joiningDate: json["JoiningDate"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "jobID": jobId,
        "candidateID": candidateId,
        "employerID": employerId,
        "OfferedBasicSalary": offeredBasicSalary,
        "OfferedGrossSalary": offeredGrossSalary,
        "Designation": designation,
        "Note": note,
        "JoiningDate": joiningDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "__v": v,
      };
}
