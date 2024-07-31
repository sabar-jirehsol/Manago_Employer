import 'dart:convert';

AddOfferLetterModel addOfferLetterModelFromJson(String str) =>
    AddOfferLetterModel.fromJson(json.decode(str));

String addOfferLetterModelToJson(AddOfferLetterModel data) =>
    json.encode(data.toJson());

class AddOfferLetterModel {
  AddOfferLetterModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory AddOfferLetterModel.fromJson(Map<String, dynamic> json) {
    return AddOfferLetterModel(
      message: json["message"],
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
  };
}

class Data {
  Data({
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
  String? candidateId;
  String? documentType;
  String? joiningDate;
  int? offeredSalary;
  String? designation;
  String? description;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      createdAt: DateTime.parse(json["createdAt"] as String),
      modifiedAt: DateTime.parse(json["modifiedAt"] as String),
      isActive: json["isActive"] as bool?,
      isDeleted: json["isDeleted"] as bool?,
      id: json["_id"] as String?,
      employeeId: json["employeeID"] as String?,
      employerId: json["employerID"] as String?,
      candidateId: json["candidateID"] as String?,
      documentType: json["documentType"] as String?,
      joiningDate: json["joiningDate"] as String?,
      offeredSalary: json["offeredSalary"] as int?,
      designation: json["designation"] as String?,
      description: json["description"] as String?,
      v: json["__v"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "modifiedAt": modifiedAt?.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "employeeID": employeeId,
    "employerID": employerId,
    "candidateID": candidateId,
    "documentType": documentType,
    "joiningDate": joiningDate,
    "offeredSalary": offeredSalary,
    "designation": designation,
    "description": description,
    "__v": v,
  };
}
