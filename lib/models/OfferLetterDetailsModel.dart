// To parse this JSON data, do
//
//     final offerLetterDetailsModel = offerLetterDetailsModelFromJson(jsonString);

import 'dart:convert';

OfferLetterDetailsModel offerLetterDetailsModelFromJson(String str) =>
    OfferLetterDetailsModel.fromJson(json.decode(str));

String offerLetterDetailsModelToJson(OfferLetterDetailsModel data) =>
    json.encode(data.toJson());

class OfferLetterDetailsModel {
  OfferLetterDetailsModel({
    this.message,
    this.data,
  });

  String? message;
  List<OfferLetterDatum>? data;

  factory OfferLetterDetailsModel.fromJson(Map<String, dynamic> json) =>
      OfferLetterDetailsModel(
        message: json["message"],
        data: List<OfferLetterDatum>.from(
            json["data"].map((x) => OfferLetterDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OfferLetterDatum {
  OfferLetterDatum({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.employeeId,
    this.employerId,
    this.candidateId,
    this.joiningDate,
    this.relivingDate,
    this.offeredSalary,
    this.salaryType,
    this.designation,
    this.description,
    this.v,
    this.modifiedBy,
    this.createdBy,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? employeeId;
  EmployerId? employerId;
  CandidateId? candidateId;
  String? joiningDate;
  String? relivingDate;
  int? offeredSalary;
  String? salaryType;
  String? designation;
  String? description;
  int? v;
  String? modifiedBy;
  String? createdBy;

  factory OfferLetterDatum.fromJson(Map<String, dynamic> json) =>
      OfferLetterDatum(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        employeeId: json["employeeID"],
        employerId: EmployerId.fromJson(json["employerID"]),
        candidateId: CandidateId.fromJson(json["candidateID"]),
        joiningDate: json["joiningDate"],
        relivingDate: json["relivingDate"],
        offeredSalary: json["offeredSalary"],
        salaryType: json["salaryType"],

        designation: json["designation"],
        description: json["description"],
        v: json["__v"],
        modifiedBy: json["modifiedBy"],
        createdBy: json["createdBy"],
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
        "joiningDate": joiningDate,
        "relivingDate": relivingDate,
        "offeredSalary": offeredSalary,
    " salaryType": salaryType,
        "designation": designation,
        "description": description,
        "__v": v,
        "modifiedBy": modifiedBy,
        "createdBy": createdBy,
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
    this.pincode,
    this.userId,
    this.v,
    this.annualTurnover,
    this.totalStaff,
    this.gstnNo,
    this.firmType,
    this.businessName,
    this.businessAddress,
    this.businessCity,
    this.businessState,
    this.city,
    this.state,
    this.address,
    this.email,
    this.name,
    this.profilePic,

  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? mobile;
  String? pincode;
  String? userId;
  int? v;
  String? annualTurnover;
  int? totalStaff;
  String? gstnNo;
  String? firmType;
  String? businessName;
  String? businessAddress;
  String? businessCity;
  String? businessState;
  String? city;
  String? state;
  String? address;
  String? email;
  String? name;
  String? profilePic;

  factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        mobile: json["mobile"],
        pincode: json["pincode"],
        userId: json["userId"],
        v: json["__v"],
        annualTurnover: json["annualTurnover"],
        totalStaff: json["totalStaff"],
        gstnNo: json["GSTNNo"],
        firmType: json["firmType"],
        businessName: json["businessName"],
        businessAddress: json['businessAddress'],

        businessCity:json["businessCity"],
        businessState:json["businessState"],
        city: json["city"],
        state: json["state"],
        address: json["address"],
        email: json["email"],
        name: json["name"],
    profilePic:json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "mobile": mobile,
    "pincode":pincode,
        "userId": userId,
        "__v": v,
        "annualTurnover": annualTurnover,
        "totalStaff": totalStaff,
        "GSTNNo": gstnNo,
        "firmType": firmType,
        "businessName": businessName,
         "businessAddress":businessAddress,
    "businessCity":businessCity,
  "businessState":businessState,
        "city": city,
        "state": state,
        "address": address,
        "email": email,
        "name": name,
      };
}
