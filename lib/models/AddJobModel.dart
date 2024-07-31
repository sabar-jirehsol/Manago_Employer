// To parse this JSON data, do
//
//     final addJobModel = addJobModelFromJson(jsonString);

import 'dart:convert';

AddJobModel addJobModelFromJson(String str) =>
    AddJobModel.fromJson(json.decode(str));

String addJobModelToJson(AddJobModel data) => json.encode(data.toJson());

class AddJobModel {
  AddJobModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory AddJobModel.fromJson(Map<String, dynamic> json) => AddJobModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class Data {
  Data({
    this.keyskills,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.jobTitle,
    this.designation,
    this.experience,
    this.minexperience,
    this.maxexperience,
    this.salary,
    this.vaccancy,
    this.description,
    this.v,
  });

  List<String>? keyskills;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? jobTitle;
  String? designation;
  // String? experience;
  int? experience;
  int? minexperience;
  int? maxexperience;
  int? salary;
  int? vaccancy;
  String? description;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        keyskills: List<String>.from(json["keyskills"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        jobTitle: json["jobTitle"],
        designation: json["designation"],
        experience: json["experience"],
    minexperience: json["minExperience"],
    maxexperience: json["maxExperience"],
        salary: json["salary"],
        vaccancy: json["vaccancy"],
        description: json["description"],
        v: json["__v"],
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
        "__v": v,
      };
}
