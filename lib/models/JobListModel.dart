// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'dart:convert';

JobListModel jobListModelFromJson(String str) =>
    JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  JobListModel({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
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
    this.country,
    this.state,
    this.city,
    this.keyskills,
    //this.location,
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
    this.employerId,
    this.v,
    this.status,
    this.url,
  });

  List<String>? keyskills;
  //List<String>? location;
  List<String>? country;
  List<String>? state;
  List<String>? city;
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
  EmployerId? employerId;
  int? v;
  String? status;
  String? url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        keyskills: List<String>.from(json["keyskills"].map((x) => x)),
        //location: List<String>.from(json["state"]..map((x) => x)),
    country: List<String>.from(json["country"]..map((x) => x)),
        state: List<String>.from(json["state"]..map((x) => x)),
        city: List<String>.from(json["city"]..map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        jobTitle: json["jobTitle"],
        designation: json["designation"],
        experience: json["experience"],
        minexperience:json["minExperience"],
        maxexperience:json["maxExperience"],
        salary: json["salary"],
        vaccancy: json["vaccancy"],
        description: json["description"],
        employerId: employerIdValues.map![json["employerID"]],
        v: json["__v"],
        status: json["status"] == null ? null : json["status"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "keyskills": List<dynamic>.from(keyskills!.map((x) => x)),
        //"city":List<dynamic>.from(location!.map((x) => x)),
    "country":List<dynamic>.from(country!.map((x) => x)),
    "state":List<dynamic>.from(state!.map((x) => x)),
    "city":List<dynamic>.from(city!.map((x) => x)),
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "jobTitle": jobTitle,
        "designation": designation,
        "experience": experience,
        "minexperience":minexperience,
    "maxexperience":maxexperience,
        "salary": salary,
        "vaccancy": vaccancy,
        "description": description,
        "employerID": employerIdValues.reverse[employerId],
        "__v": v,
        "status": status == null ? null : status,
        "url": url == null ? null : url,
      };
}

enum EmployerId { THE_607_D3_C880_C2_F40551_B5_FAB10 }

final employerIdValues = EnumValues({
  "607d3c880c2f40551b5fab10": EmployerId.THE_607_D3_C880_C2_F40551_B5_FAB10
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
