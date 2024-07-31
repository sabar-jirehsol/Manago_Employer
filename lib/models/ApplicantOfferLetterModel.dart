// To parse this JSON data, do
//
//     final offerLetterListModel = offerLetterListModelFromJson(jsonString);

import 'dart:convert';

ApplicantOfferLetterListModel offerLetterListModelFromJson(String str) =>
    ApplicantOfferLetterListModel.fromJson(json.decode(str));

String offerLetterListModelToJson(ApplicantOfferLetterListModel data) =>
    json.encode(data.toJson());

class ApplicantOfferLetterListModel {
  ApplicantOfferLetterListModel({
    this.message,
    this.data,
  });

  String? message;
  List<ApplicantOfferLetterListDatum>? data;

  factory ApplicantOfferLetterListModel.fromJson(Map<String, dynamic> json) =>
      ApplicantOfferLetterListModel(
        message: json["message"],
        data: List<ApplicantOfferLetterListDatum>.from(json["data"].map((x) => ApplicantOfferLetterListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ApplicantOfferLetterListDatum {
  ApplicantOfferLetterListDatum({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.employeeId,
    this.employerId,
    this.candidateId,
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
  EmployerId? employerId;
  CandidateId? candidateId;
  String? documentType;
  String? joiningDate;
  String? relivingDate;
  int? offeredSalary;
  String? designation;
  String? description;
  int? v;

  factory ApplicantOfferLetterListDatum.fromJson(Map<String, dynamic> json) => ApplicantOfferLetterListDatum(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        employeeId: json["employeeID"],
        employerId: EmployerId.fromJson(json["employerID"]),
        candidateId: CandidateId.fromJson(json["candidateID"]),
        documentType: json["documentType"],
        joiningDate: json["joiningDate"],
        relivingDate: json["relivingDate"],
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
        "documentType": documentType,
        "joiningDate": joiningDate,
        "relivingDate": relivingDate,
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
        personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "personalInfo": personalInfo,
        "_id": id,
      };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
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

class EmployerId {
  EmployerId({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.mobile,
    this.userId,
    this.v,
    this.annualTurnover,
    this.totalStaff,
    this.gstnNo,
    this.firmType,
    this.businessName,
    this.city,
    this.state,
    this.address,
    this.email,
    this.name,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? mobile;
  String? userId;
  int? v;
  String? annualTurnover;
  int? totalStaff;
  String? gstnNo;
  String? firmType;
  String? businessName;
  String? city;
  String? state;
  String? address;
  String? email;
  String? name;

  factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        mobile: json["mobile"],
        userId: json["userId"],
        v: json["__v"],
        annualTurnover: json["annualTurnover"],
        totalStaff: json["totalStaff"],
        gstnNo: json["GSTNNo"],
        firmType: json["firmType"],
        businessName: json["businessName"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "mobile": mobile,
        "userId": userId,
        "__v": v,
        "annualTurnover": annualTurnover,
        "totalStaff": totalStaff,
        "GSTNNo": gstnNo,
        "firmType": firmType,
        "businessName": businessName,
        "city": city,
        "state": state,
        "address": address,
        "email": email,
        "name": name,
      };
}
