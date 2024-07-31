import 'dart:convert';

CandidateDetailsModel candidateDetailsModelFromJson(String str) =>
    CandidateDetailsModel.fromJson(json.decode(str));

String candidateDetailsModelToJson(CandidateDetailsModel data) =>
    json.encode(data.toJson());

class CandidateDetailsModel {
  CandidateDetailsModel({
    this.message,
    this.data,
  });

  String? message;
  CandidateData? data;

  factory CandidateDetailsModel.fromJson(Map<String, dynamic> json) =>
      CandidateDetailsModel(
        message: json["message"],
        data: json["data"] != null
            ? CandidateData.fromJson(json["data"])
            : null,
        // this a map  for getting values from API.
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data != null ? data!.toJson() : null,
  };
}

class CandidateData {
  CandidateData({
    this.personalInfo,
    this.professionalInfo,
    this.educationalInfo,
    this.jobPreference,
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
  EducationalInfo? educationalInfo;
  JobPreference? jobPreference;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? userId;
  int? v;

  factory CandidateData.fromJson(Map<String, dynamic> json) => CandidateData(
    personalInfo: json["personalInfo"] != null
        ? PersonalInfo.fromJson(json["personalInfo"])
        : null,
    professionalInfo: json["professionalInfo"] != null
        ? ProfessionalInfo.fromJson(json["professionalInfo"])
        : null,
    educationalInfo: json["educationalInfo"] != null
        ? EducationalInfo.fromJson(json["educationalInfo"])
        : null,
    jobPreference: json["jobPreference"] != null
        ? JobPreference.fromJson(json["jobPreference"])
        : null,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
    modifiedAt: json["modifiedAt"] != null
        ? DateTime.parse(json["modifiedAt"])
        : null,
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    userId: json["userId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo != null ? personalInfo!.toJson() : null,
    "professionalInfo":
    professionalInfo != null ? professionalInfo!.toJson() : null,
    "educationalInfo":
    educationalInfo != null ? educationalInfo!.toJson() : null,
    "jobPreference": jobPreference != null ? jobPreference!.toJson() : null,
    "createdAt": createdAt != null ? createdAt!.toIso8601String() : null,
    "modifiedAt": modifiedAt != null ? modifiedAt!.toIso8601String() : null,
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

  factory EducationalInfo.fromJson(Map<String, dynamic> json) => EducationalInfo(
    highestQualification: json["highestQualification"],
    educationDetails: json["educationDetails"] != null
        ? List<EducationDetail>.from(json["educationDetails"].map((x) => EducationDetail.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "highestQualification": highestQualification,
    "educationDetails": educationDetails != null ? List<dynamic>.from(educationDetails!.map((x) => x.toJson())) : null,
  };
}

class EducationDetail {
  EducationDetail({
    this.id,
    this.qualification,
    this.educationType,
    this.specialization,
    this.university,
    this.startDate,
    this.endDate,
    this.passingYear, // Added passingYear field
    this.awardsAndAchivement,
  });

  String? id;
  String? qualification;
  String? educationType;
  String? specialization;
  String? university;
  String? startDate;
  String? endDate;
  String? passingYear; // Added passingYear field
  String? awardsAndAchivement;

  factory EducationDetail.fromJson(Map<String, dynamic> json) => EducationDetail(
    id: json["_id"],
    qualification: json["qualification"],
    educationType: json["educationType"],
    specialization: json["specialization"],
    university: json["university"],
    startDate: json["startDate"],
    endDate: json["endDate"],

    passingYear: json["passingYear"] != null ? json["passingYear"].toString() : null,
   // passingYear: json["passingYear"].toString(), // Added passingYear field
    awardsAndAchivement: json["awardsAndAchivement"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "qualification": qualification,
    "educationType": educationType,
    "specialization": specialization,
    "university": university,
    "startDate": startDate,
    "endDate": endDate,
    "passingYear": passingYear, // Added passingYear field
    "awardsAndAchivement": awardsAndAchivement,
  };
}


class ProfessionalInfo {
  ProfessionalInfo({
    this.keySkills,
    this.totalExperience,
    this.preferredIndustry,
    this.preferredFunction,
    this.jobDetails,
  });

  List<String>? keySkills;
  double? totalExperience;
  String? preferredIndustry;
  String? preferredFunction;
  List<JobDetail>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) => ProfessionalInfo(
    keySkills: List<String>.from(json["keySkills"].map((x) => x)),
    totalExperience: json["totalExperience"].toDouble(),
    preferredIndustry: json["prefferedIndustry"],
    preferredFunction: json["preferedFunction"],
    jobDetails: List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "keySkills": List<dynamic>.from(keySkills!.map((x) => x)),
    "totalExperience": totalExperience,
    "preferredIndustry": preferredIndustry,
    "preferredFunction": preferredFunction,
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
    this.currentlyWorkHere,
    this.Salary,
    this.salaryType,
    this.paymentMethod,
    this.city,
    this.jobSummary,
  });

  String? id;
  String? jobTitle;
  String? employer;
  String? startDate;
  String? endDate;
  // bool? currentlyWorkHere;
  String? currentlyWorkHere;
  int? Salary;
  String? salaryType;
  String? paymentMethod;
  String? city;
  String? jobSummary;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    employer: json["employer"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    currentlyWorkHere: json["IcurrentlyWorkHere"],
    Salary: json["Salary"],
    salaryType: json["salaryType"],
    paymentMethod: json["paymentMethod"],
    city: json["city"],
    jobSummary: json["jobSummary"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "employer": employer,
    "startDate": startDate,
    "endDate": endDate,
    "currentlyWorkHere": currentlyWorkHere,
    "Salary": Salary,
    "salaryType": salaryType,
    "paymentMethod": paymentMethod,
    "city": city,
    "jobSummary": jobSummary,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
    this.email,
    this.dialcode,
    this.mobile,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.dob,
    this.maritalStatus,
    this.gender,
    this.aadhar,
    this.introduction,
    this.profilePic,
  });

  String? name;
  String? email;
  String? dialcode;
  String? mobile;
  String? address;
  String? state;
  String? city;
  int? pincode;
  String? dob;
  String? maritalStatus;
  String? gender;
  String? aadhar;
  String? introduction;
  String? profilePic;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    dialcode: json["dial_code"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pincode: json["pinCode"],
    dob: json["dob"],
    maritalStatus: json["maritialStatus"],
    gender: json["gender"],
    aadhar: json["Aadhar"],
    introduction: json["introduction"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile": mobile,
    "address": address,
    "state": state,
    "city": city,
    "pinCode": pincode,
    "dob": dob,
    "maritialStatus": maritalStatus,
    "gender": gender,
    "Aadhar": aadhar,
    "introduction": introduction,
  };
}

class JobPreference {
  JobPreference({
    this.preferredLocation,
    this.preferredRole,
    this.language,
    this.profileTitle,
    this.strength,
    this.weakness,
  });

  List<String>? preferredLocation;
  List<String>? preferredRole;
  List<String>? language;
  String? profileTitle;
  String? strength;
  String? weakness;

  factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
    preferredLocation: List<String>.from(json["preferedLocation"].map((x) => x)),
    preferredRole: List<String>.from(json["prefferedRole"].map((x) => x)),
    language: List<String>.from(json["language"].map((x) => x)),
    profileTitle: json["profileTitle"],
    strength: json["strength"],
    weakness: json["weakness"],
  );

  get shiftType => null;

  Map<String, dynamic> toJson() => {
    "preferedLocation": List<dynamic>.from(preferredLocation!.map((x) => x)),
    "prefferedRole": List<dynamic>.from(preferredRole!.map((x) => x)),
    "language": List<dynamic>.from(language!.map((x) => x)),
    "profileTitle": profileTitle,
    "strength": strength,
    "weakness": weakness,
  };
}
