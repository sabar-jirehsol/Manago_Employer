// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

JobDetailsModel jobDetailsModelFromJson(String str) => JobDetailsModel.fromJson(json.decode(str));

String jobDetailsModelToJson(JobDetailsModel data) => json.encode(data.toJson());

class JobDetailsModel {
    JobDetailsModel({
        this.message,
        this.data,
    });

    String? message;
    Data? data;

    factory JobDetailsModel.fromJson(Map<String, dynamic> json) => JobDetailsModel(
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
        this.country,
        this.state,
        this.city,
       // this.location,
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
        this.employerId,
        this.v,
    });
    List<String>? country;
    List<String>? state;
    List<String>? city;
   // List<String>? location;
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
    EmployerId? employerId;
    int? v;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        //location: List<String>.from(json["location"].map((x) => x)),
        country: List<String>.from(json["country"]..map((x) => x)),
        state: List<String>.from(json["state"]..map((x) => x)),
        city: List<String>.from(json["city"]..map((x) => x)),
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
        employerId: EmployerId.fromJson(json["employerID"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {

        //"location": List<dynamic>.from(location!.map((x) => x)),
        "country": List<dynamic>.from(country!.map((x) => x)),
        "state": List<dynamic>.from(state!.map((x) => x)),
        "city": List<dynamic>.from(city!..map((x) => x)),
        "keyskills": List<dynamic>.from(keyskills!.map((x) => x)),
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
        "employerID": employerId,
        "__v": v,
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
        this.gstnNo,
        this.address,
        this.annualTurnover,
        this.businessName,
        this.city,
        this.email,
        this.firmType,
        this.name,
        this.state,
        this.country,
        this.totalStaff,
    });

    DateTime? createdAt;
    DateTime? modifiedAt;
    bool? isActive;
    bool? isDeleted;
    String? id;
    String? mobile;
    String? userId;
    int? v;
    dynamic gstnNo;
    String? address;
    dynamic annualTurnover;
    String? businessName;
    String? city;
    String? email;
    String? firmType;
    String? name;
    String? state;
    String? country;
    dynamic totalStaff;

    factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        mobile: json["mobile"],
        userId: json["userId"],
        v: json["__v"],
        gstnNo: json["GSTNNo"],
        address: json["address"],
        annualTurnover: json["annualTurnover"],
        businessName: json["businessName"],
        country:json["country"],
        city: json["city"],
        email: json["email"],
        firmType: json["firmType"],
        name: json["name"],
        state: json["state"],
        totalStaff: json["totalStaff"],
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
        "GSTNNo": gstnNo,
        "address": address,
        "annualTurnover": annualTurnover,
        "businessName": businessName,
        "city": city,
        "email": email,
        "firmType": firmType,
        "name": name,
        "state": state,
        "country":country,
        "totalStaff": totalStaff,
    };
}
