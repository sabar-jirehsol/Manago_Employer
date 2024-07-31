import 'dart:convert';

ApplicantDetailsProfileViewModel applicantProfileViewModelFromJson(String str) =>
    ApplicantDetailsProfileViewModel.fromJson(json.decode(str));

String applicantProfileViewModelToJson(ApplicantDetailsProfileViewModel data) => json.encode(data.toJson());

class ApplicantDetailsProfileViewModel {
  ApplicantDetailsProfileViewModel({
    this.data,
  });

  ApplicantsDetailsProdileViewData? data;

  factory ApplicantDetailsProfileViewModel.fromJson(Map<String, dynamic> json) => ApplicantDetailsProfileViewModel(
    data: json["data"] != null ? ApplicantsDetailsProdileViewData.fromJson(json["data"]) : null,
    // this a map  for getting values from API.
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ApplicantsDetailsProdileViewData {
  ApplicantsDetailsProdileViewData({
    this.personalInfo,
    this.professionalInfo,
    this.jobPreference,
    this.educationalInfo,
    this.isActive,
    this.isDeleted,
    this.id,
    this.userId,
    this.createdAt,
    this.modifiedAt,
    this.v,
  });

  PersonalInfo? personalInfo;
  ProfessionalInfo? professionalInfo;
  JobPreference? jobPreference;
  EducationalInfo? educationalInfo;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? v;

  factory ApplicantsDetailsProdileViewData.fromJson(Map<String, dynamic> json) => ApplicantsDetailsProdileViewData(
    personalInfo: json["personalInfo"] != null ? PersonalInfo.fromJson(json["personalInfo"]) : null,
    professionalInfo: json["professionalInfo"] != null ? ProfessionalInfo.fromJson(json["professionalInfo"]) : null,
    jobPreference: json["jobPreference"] != null ? JobPreference.fromJson(json["jobPreference"]) : null,
    educationalInfo: json["educationalInfo"] != null ? EducationalInfo.fromJson(json["educationalInfo"]) : null,
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    userId: json["userId"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    modifiedAt: json["modifiedAt"] != null ? DateTime.parse(json["modifiedAt"]) : null,
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo?.toJson(),
    "professionalInfo": professionalInfo?.toJson(),
    "jobPreference": jobPreference?.toJson(),
    "educationalInfo": educationalInfo?.toJson(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "modifiedAt": modifiedAt?.toIso8601String(),
    "__v": v,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
    this.dialCode,
    this.mobile,
    this.email,
    this.gender,
    this.dob,
    this.address,
    this.state,
    this.city,
    this.country,
    this.pinCode,
    this.maritialStatus,
    this.aadhar,
    this.introduction,
    this.profilePic,
  });

  String? name;
  String? dialCode;
  String? mobile;
  String? email;
  String? gender;
  String? dob;
  String? address;
  String? state;
  String? city;
  String? country;
  int? pinCode;
  String? maritialStatus;
  String? aadhar;
  String? introduction;
  String? profilePic;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    dialCode: json["dial_code"],
    mobile: json["mobile"],
    email: json["email"],
    gender: json["gender"],
    dob: json["dob"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    country: json["country"],
    pinCode: json["pinCode"],
    maritialStatus: json["maritialStatus"],
    aadhar: json["Aadhar"],
    introduction: json["introduction"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dial_code": dialCode,
    "mobile": mobile,
    "email": email,
    "gender": gender,
    "dob": dob,
    "address": address,
    "state": state,
    "city": city,
    "country": country,
    "pinCode": pinCode,
    "maritialStatus": maritialStatus,
    "Aadhar": aadhar,
    "introduction": introduction,
    "profilePic": profilePic,
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

  int? totalExperience;
  List<String>? keySkills;
  String? prefferedIndustry;
  String? preferedFunction;
  List<JobDetails>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) => ProfessionalInfo(
    totalExperience: json["totalExperience"],
    keySkills: json["keySkills"] != null ? List<String>.from(json["keySkills"].map((x) => x)) : null,
    prefferedIndustry: json["prefferedIndustry"],
    preferedFunction: json["preferedFunction"],
    jobDetails: json["jobDetails"] != null ? List<JobDetails>.from(json["jobDetails"].map((x) => JobDetails.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "totalExperience": totalExperience,
    "keySkills": keySkills != null ? List<dynamic>.from(keySkills!.map((x) => x)) : null,
    "prefferedIndustry": prefferedIndustry,
    "preferedFunction": preferedFunction,
    "jobDetails": jobDetails != null ? List<dynamic>.from(jobDetails!.map((x) => x.toJson())) : null,
  };
}

class JobDetails {
  JobDetails({
    this.id,
    this.jobTitle,
    this.employer,
    this.jobExperience,
    this.startDate,
    this.endDate,
    this.icurrentlyWorkHere,
    this.salary,
    this.salaryType,
    this.paymentMethod,
    this.city,
    this.jobSummary,
  });

  String? id;
  String? jobTitle;
  String? employer;
  dynamic jobExperience;
  String? startDate;
  String? endDate;
  String? icurrentlyWorkHere;
  int? salary;
  String? salaryType;
  String? paymentMethod;
  String? city;
  String? jobSummary;

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    employer: json["employer"],
    jobExperience: json["jobExperience"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    icurrentlyWorkHere: json["IcurrentlyWorkHere"],
    salary: json["Salary"],
    salaryType: json["salaryType"],
    paymentMethod: json["paymentMethod"],
    city: json["city"],
    jobSummary: json["jobSummary"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "employer": employer,
    "jobExperience": jobExperience,
    "startDate": startDate,
    "endDate": endDate,
    "IcurrentlyWorkHere": icurrentlyWorkHere,
    "Salary": salary,
    "salaryType": salaryType,
    "paymentMethod": paymentMethod,
    "city": city,
    "jobSummary": jobSummary,
  };
}

class JobPreference {
  JobPreference({
    this.preferedLocation,
    this.prefferedRole,
    this.language,
    this.profileTitle,
    this.strength,
    this.weakness,
  });

  List<String>? preferedLocation;
  List<String>? prefferedRole;
  List<String>? language;
  String? profileTitle;
  String? strength;
  String? weakness;

  factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
    preferedLocation: json["preferedLocation"] != null ? List<String>.from(json["preferedLocation"].map((x) => x)) : null,
    prefferedRole: json["prefferedRole"] != null ? List<String>.from(json["prefferedRole"].map((x) => x)) : null,
    language: json["language"] != null ? List<String>.from(json["language"].map((x) => x)) : null,
    profileTitle: json["profileTitle"],
    strength: json["strength"],
    weakness: json["weakness"],
  );

  Map<String, dynamic> toJson() => {
    "preferedLocation": preferedLocation != null ? List<dynamic>.from(preferedLocation!.map((x) => x)) : null,
    "prefferedRole": prefferedRole != null ? List<dynamic>.from(prefferedRole!.map((x) => x)) : null,
    "language": language != null ? List<dynamic>.from(language!.map((x) => x)) : null,
    "profileTitle": profileTitle,
    "strength": strength,
    "weakness": weakness,
  };
}

class EducationalInfo {
  EducationalInfo({
    this.highestQualification,
    this.educationDetails,
  });

  String? highestQualification;
  List<EducationDetails>? educationDetails;

  factory EducationalInfo.fromJson(Map<String, dynamic> json) => EducationalInfo(
    highestQualification: json["highestQualification"],
    educationDetails: json["educationDetails"] != null
        ? List<EducationDetails>.from(json["educationDetails"].map((x) => EducationDetails.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "highestQualification": highestQualification,
    "educationDetails": educationDetails != null ? List<dynamic>.from(educationDetails!.map((x) => x.toJson())) : null,
  };
}

class EducationDetails {
  EducationDetails({
    this.id,
    this.qualification,
    this.educationType,
    this.specialization,
    this.university,
    this.startDate,
    this.endDate,
    this.awardsAndAchivement,
  });

  String? id;
  dynamic qualification;
  String? educationType;
  String? specialization;
  String? university;
  String? startDate;
  String? endDate;
  String? awardsAndAchivement;

  factory EducationDetails.fromJson(Map<String, dynamic> json) => EducationDetails(
    id: json["_id"],
    qualification: json["qualification"],
    educationType: json["educationType"],
    specialization: json["specialization"],
    university: json["university"],
    startDate: json["startDate"],
    endDate: json["endDate"],
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
    "awardsAndAchivement": awardsAndAchivement,
  };
}
