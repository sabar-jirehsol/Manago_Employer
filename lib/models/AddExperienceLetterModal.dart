import 'dart:convert';

AddExperienceLetterModel addExperienceLetterModelFromJson(String str) =>
    AddExperienceLetterModel.fromJson(json.decode(str));

String addExperienceLetterModelToJson(AddExperienceLetterModel data) =>
    json.encode(data.toJson());

class AddExperienceLetterModel {
  AddExperienceLetterModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory AddExperienceLetterModel.fromJson(Map<String, dynamic> json) =>
      AddExperienceLetterModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data!.toJson(),
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
    this.documentType, // Correctly spelled
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
  String? candidateId;
  String? documentType; // Correctly spelled
  String? joiningDate;
  String? relivingDate;
  int? offeredSalary;
  String? designation;
  String? description;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    employeeId: json["employeeID"],
    employerId: json["employerID"],
    candidateId: json["candidateID"],
    documentType: json["documentType"], // Correctly spelled
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
    "documentType": documentType, // Correctly spelled
    "joiningDate": joiningDate,
    "relivingDate": relivingDate,
    "offeredSalary": offeredSalary,
    "designation": designation,
    "description": description,
    "__v": v,
  };
}
