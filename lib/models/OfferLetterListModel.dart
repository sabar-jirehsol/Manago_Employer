// To parse this JSON data, do
//
//     final offerLetterListModel = offerLetterListModelFromJson(jsonString);

import 'dart:convert';

OfferExperienceLetterListModel offerLetterListModelFromJson(String str) =>
    OfferExperienceLetterListModel.fromJson(json.decode(str));

String offerLetterListModelToJson(OfferExperienceLetterListModel data) =>
    json.encode(data.toJson());

class OfferExperienceLetterListModel {
  OfferExperienceLetterListModel({
    this.message,
    this.data,
  });

  String? message;
  List<LetterListDatum>? data;

  factory OfferExperienceLetterListModel.fromJson(Map<String, dynamic> json) =>
      OfferExperienceLetterListModel(
        message: json["message"],
        data: List<LetterListDatum>.from(
            json["data"].map((x) => LetterListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LetterListDatum {
  LetterListDatum({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.employeeId,
    this.employerId,
    this.candidateId,
    this.applicationId,
    this.documentType,
    this.joiningDate,
    this.relivingDate,
    this.offeredSalary,
    this.designation,
    this.description,
    this.v,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? employeeId;
  String? employerId;
  CandidateId? candidateId;
  String? applicationId;
  String? documentType;
  String? joiningDate;
  String? relivingDate;
  int? offeredSalary;
  String? designation;
  String? description;
  int? v;

  factory LetterListDatum.fromJson(Map<String, dynamic> json) =>
      LetterListDatum(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        employeeId: json["employeeID"],
        employerId: json["employerID"],
        candidateId: CandidateId.fromJson(json["candidateID"]),
        applicationId:json["applicationID"],
        documentType: json["documentType"],
        joiningDate: json["joiningDate"],
        relivingDate:
            json["relivingDate"] == null ? null : json["relivingDate"],
        offeredSalary: json["offeredSalary"],
        designation: json["designation"],
        description: json["description"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "employeeID": employeeId,
        "employerID": employerId,
        "candidateID": candidateId,
       "applicationID":applicationId,
        "documentType": documentType,
        "joiningDate": joiningDate,
        "relivingDate": relivingDate == null ? null : relivingDate,
        "offeredSalary": offeredSalary,
        "designation": designation,
        "description": description,
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
        personalInfo: json["personalInfo"] == null
            ? null
            : PersonalInfo.fromJson(json["personalInfo"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "personalInfo": personalInfo == null ? null : personalInfo,
        "_id": id,
      };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
    this.dial_code,
    this.mobile,
    this.email,
    this.address,
    this.state,
    this.city,
    this.pinCode,
    this.dob,
    this.maritialStatus,
    this.gender,
    this.aadhar,
  });

  String? name;
  String? dial_code;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? city;
  int? pinCode;
  String? dob;
  String? maritialStatus;
  String? gender;
  String? aadhar;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        name: json["name"],
        dial_code: json["dial_code"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        pinCode: json["pinCode"],
        dob: json["dob"],
        maritialStatus: json["maritialStatus"],
        gender: json["Gender"],
        aadhar: json["Aadhar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
       "dial_code":dial_code,
        "mobile": mobile,
        "email": email,
        "address": address,
        "state": state,
        "city": city,
        "pinCode": pinCode,
        "dob": dob,
        "maritialStatus": maritialStatus,
        "Gender": gender,
        "Aadhar": aadhar,
      };
}
