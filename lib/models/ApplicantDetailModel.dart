// To parse this JSON data, do
//
//     final applicantionAgainstEmployerModel = applicantionAgainstEmployerModelFromJson(jsonString);

import 'dart:convert';

ApplicantDetailsModel applicantionAgainstEmployerModelFromJson(String str) =>
    ApplicantDetailsModel.fromJson(json.decode(str));

// String applicantionAgainstEmployerModelToJson(ApplicantDetailsModel data) =>
//     json.encode(data.toJson());

ApplicantsDetailsData applicantsModelFromJson(String str) =>
    ApplicantsDetailsData.fromJson(json.decode(str));

class ApplicantDetailsModel {
  ApplicantDetailsModel({
    this.message,
    this.data,
  });

  String? message;

   List<ApplicantsDetailsData>? data;


  factory ApplicantDetailsModel.fromJson(Map<String, dynamic> json) =>
      ApplicantDetailsModel(
        message: json["message"],
        data: List<ApplicantsDetailsData>.from(
            json["data"].map((x) => ApplicantsDetailsData.fromJson(x))),
      );


  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),

  };

}

class ApplicantsDetailsData {
  ApplicantsDetailsData({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.jobId,
    this.candidateId,
    this.employerId,
    this.remarks,
    this.status,
    this.exp_start_salary,
    this.exp_end_salary,
    this.v,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  JobId? jobId;
  CandidateId? candidateId;
  EmployerId? employerId;
  String? remarks;
  String? status;
  String? exp_start_salary;
  String? exp_end_salary;
  int? v;

  factory ApplicantsDetailsData.fromJson(Map<String, dynamic> json) =>
      ApplicantsDetailsData(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        jobId:JobId.fromJson(json["jobID"]??(json["job"])),
        candidateId: CandidateId.fromJson(json["candidateID"]??json["candidate"]),
        employerId: EmployerId.fromJson(json["employerID"]??json["employer"]),
        remarks: json["remarks"],
        status: json["status"],
        exp_start_salary:(json["exp_start_salary"]?? 0.0).round().toString(),
        exp_end_salary:(json["exp_end_salary"]?? 0.0).round().toString(),
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
    "remarks": remarks,
    "status": status,
    "__v": v,

  };

}

class CandidateId {
  CandidateId({
    this.personalInfo,
    this.professionalInfo,
    this.jobPreference,
    this.educationalInfo,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,

    this.id,
    this.userId,
    this.v,
  });

  PersonalInfo? personalInfo;
  ProfessionalInfo? professionalInfo;
  JobPreference? jobPreference;
  EducationalInfo? educationalInfo;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? userId;
  int? v;

  factory CandidateId.fromJson(Map<String, dynamic> json) => CandidateId(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    professionalInfo: ProfessionalInfo.fromJson(json["professionalInfo"]),
    jobPreference: JobPreference.fromJson(json["jobPreference"]),
    educationalInfo: EducationalInfo.fromJson(json["educationalInfo"]),
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],

    id: json["_id"],
    userId: json["userId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo,
    "professionalInfo": professionalInfo,
    "jobPreference": jobPreference,
    "educationalInfo": educationalInfo,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "userId": userId,
    "__v": v,
  };
}

class EducationalInfo {
  EducationalInfo({
    this.highestQualification,
    this.educationDetails,
  });

  String? highestQualification;
  List<EducationDetail>? educationDetails;

  factory EducationalInfo.fromJson(Map<String, dynamic> json) =>
      EducationalInfo(
        highestQualification: json["highestQualification"],
        educationDetails: List<EducationDetail>.from(
            json["educationDetails"].map((x) => EducationDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "highestQualification": highestQualification,
    "educationDetails":
    List<dynamic>.from(educationDetails!.map((x) => x.toJson())),
  };
}

class EducationDetail {
  EducationDetail({
    this.id,
    this.qualification,
    this.educationType,
    this.specialization,
    this.university,
    this.passingYear,
    this.startDate,
    this.endDate,
    this.awardsAndAchivement,
    this.document,
  });

  String? id;
  String? qualification;
  String? educationType;
  String? specialization;
  String? university;
  String?startDate;
  String? endDate;
  String? passingYear;
  String? awardsAndAchivement;
  String? document;

  factory EducationDetail.fromJson(Map<String, dynamic> json) =>
      EducationDetail(
        id: json["_id"],
        qualification: json["qualification"],
        educationType:json["educationType"],
        specialization: json["specialization"],
        university: json["university"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        passingYear: json["passingYear"],
        awardsAndAchivement: json["awardsAndAchivement"],
        document: json["document"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "qualification": qualification,
    "educationType":educationType,
    "specialization": specialization,
    "university": university,
    "passingYear": passingYear,
    "awardsAndAchivement": awardsAndAchivement,
    "document": document,
  };
}

class JobPreference {
  JobPreference({
    this.preferedLocation,
    this.prefferedRole,
    this.language,
    this.profileTitle,
    this.shiftType,
    this.iAmSpeciallyAbled,
    this.strength,
    this.weakness,
  });

  List<String>? preferedLocation;
  String? prefferedRole;
  String? language;
  String? profileTitle;
  String? shiftType;
  String? iAmSpeciallyAbled;
  String? strength;
  String? weakness;

  factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
    preferedLocation: json["preferedLocation"] == ''
        ? [json["preferedLocation"]] // List<String>()
        : List<String>.from(json["preferedLocation"].map((x) => x)),
    prefferedRole: json["prefferedRole"][0],
    //  == ''
    //     ? [json["prefferedRole"]] // List<String>()
    //     : List<String>.from(json["prefferedRole"].map((x) => x)),
    language: json["language"][0],
    //  == ''
    //     ?[json["language"]]// List<String>()
    //     : List<String>.from(json["language"].map((x) => x)),
    profileTitle: json["profileTitle"],
    shiftType: json["shiftType"],
    iAmSpeciallyAbled: json["iAmSpeciallyAbled"],
    strength: json["strength"],
    weakness: json["weakness"],
  );

  Map<String, dynamic> toJson() => {
    "preferedLocation": [
      preferedLocation
    ], //List<dynamic>.from(preferedLocation.map((x) => x)),
    "prefferedRole":
    prefferedRole, //List<dynamic>.from(prefferedRole.map((x) => x)),
    "language": language, //List<dynamic>.from(language.map((x) => x)),
    "profileTitle": profileTitle,
    "shiftType": shiftType,
    "iAmSpeciallyAbled": iAmSpeciallyAbled,
    "strength": strength,
    "weakness": weakness,
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
    this.maritialStatus,
    this.gender,
    this.introduction,
    this.aadhar,
    this.profilePic,
  });

  String? name;
  String? dialcode;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? city;
  int? pinCode;
  String? dob;
  String? maritialStatus;
  String? gender;
  String? introduction;
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
    maritialStatus: json["maritialStatus"],
    gender: json["gender"],
    introduction: json["introduction"],
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
    "maritialStatus": maritialStatus,
    "Gender": gender,
    "introduction":introduction,
    "Aadhar": aadhar,
  };
}

class ProfessionalInfo {
  ProfessionalInfo({
    this.totalExperience,
    this.keySkills,
    this.prefferedIndustry,
    this.preferedFunction,
    this.jobDetails,
  });

  num? totalExperience;
  List<String>? keySkills;
  String? prefferedIndustry;
  String? preferedFunction;
  List<JobDetail>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) =>
      ProfessionalInfo(
        totalExperience: json["totalExperience"],
        keySkills: List<String>.from(json["keySkills"].map((x) => x)),
        prefferedIndustry: json["prefferedIndustry"],
        preferedFunction: json["preferedFunction"],
        jobDetails: List<JobDetail>.from(
            json["jobDetails"].map((x) => JobDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalExperience": totalExperience,
    "keySkills": List<dynamic>.from(keySkills!.map((x) => x)),
    "prefferedIndustry": prefferedIndustry,
    "preferedFunction": preferedFunction,
    "jobDetails": List<dynamic>.from(jobDetails!.map((x) => x.toJson())),
  };
}

class JobDetail {
  JobDetail({
    this.id,
    this.jobTitle,
    this.employer,
    this.startDate,
    this.endDate,
    this.icurrentlyWorkHere,
    this.salary,
    this.salaryType,
    this.paymentMethod,
    this.city,
    this.noticePeroid,
    this.jobSummary,
  });

  String? id;
  String? jobTitle;
  String? employer;
  String? startDate;
  String? endDate;
  String? icurrentlyWorkHere;
  int? salary;
  String? salaryType;
  String? paymentMethod;
  String? city;
  dynamic noticePeroid;
  String? jobSummary;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    employer: json["employer"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    icurrentlyWorkHere: json["IcurrentlyWorkHere"],
    salary: json["Salary"],
    salaryType: json["salaryType"],
    paymentMethod: json["paymentMethod"],
    city: json["city"],
    noticePeroid: json["noticePeroid"],
    jobSummary: json["jobSummary"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "employer": employer,
    "startDate": startDate,
    "endDate": endDate,
    "IcurrentlyWorkHere": icurrentlyWorkHere,
    "Salary": salary,
    "salaryType": salaryType,
    "paymentMethod": paymentMethod,
    "city": city,
    "noticePeroid": noticePeroid,
    "jobSummary": jobSummary,
  };
}

class Salary {
  Salary({
    this.id,
    this.perAnum,
    this.monthly,
  });

  String? id;
  String? perAnum;
  String? monthly;

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    id: json["_id"],
    perAnum: json["perAnum"],
    monthly: json["Monthly"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "perAnum": perAnum,
    "Monthly": monthly,
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
  }){// Print the id when an instance of EmployerId is created
    print("Employer IDs: $id");}

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

class JobId {
  JobId({
    this.keyskills,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.jobTitle,
    this.designation,
    this.experience,
    this.salary,
    this.vaccancy,
    this.description,
    this.employerId,
    this.v,
    this.country,this.state,this.city
  });

  List<String>? keyskills;
  List<String>? city;
  List<String>? state;
  List<String>? country;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? jobTitle;
  String? designation;
  // String? experience;
  int? experience;
  int? salary;
  int? vaccancy;
  String? description;
  String? employerId;
  int? v;

  factory JobId.fromJson(Map<String, dynamic> json) => JobId(
    keyskills: List<String>.from(json["keyskills"].map((x) => x)),
    //city: List<String>.from(json["city"].map((x) => x)),
    //state: List<String>.from(json["state"].map((x) => x)),
    //country: List<String>.from(json["country"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    jobTitle: json["jobTitle"],
    designation: json["designation"],
    experience: json["experience"],
    salary: json["salary"],
    vaccancy: json["vaccancy"],
    description: json["description"],
    employerId: json["employerID"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "keyskills": List<dynamic>.from(keyskills!.map((x) => x)),
    // "city": List<dynamic>.from(city!.map((x) => x)),
    // "state": List<dynamic>.from(state!.map((x) => x)),
    // "country": List<dynamic>.from(country!.map((x) => x)),
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
    "employerID": employerId,
    "__v": v,
  };
}
