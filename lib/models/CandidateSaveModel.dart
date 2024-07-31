import 'dart:convert';

CandidateSaveModel candidateSaveModelFromJson(String str) =>
    CandidateSaveModel.fromJson(json.decode(str));

String candidateSaveModelToJson(CandidateSaveModel data) =>
    json.encode(data.toJson());

class CandidateSaveModel {
  CandidateSaveModel({
    this.message,
    this.data,
  }){
    print(message);
  }

  String? message;
  Data? data;

  factory CandidateSaveModel.fromJson(Map<String, dynamic> json) {
    print("Parsing CandidateSaveModel:");
    print("Message: ${json["message"]}");
    print("Data:");
    print(json["data"]);

    return CandidateSaveModel(
      message: json["message"],
      data: Data.fromJson(json["data"]),
    );
  }


  // factory CandidateSaveModel.fromJson(Map<String, dynamic> json) =>
  //     CandidateSaveModel(
  //       message: json["message"],
  //       data: Data.fromJson(json["data"]),
  //     );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
  };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    professionalInfo: ProfessionalInfo.fromJson(json["professionalInfo"]),
    jobPreference: JobPreference.fromJson(json["jobPreference"]),
    educationalInfo: EducationalInfo.fromJson(json["educationalInfo"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    userId: json["userId"],
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo,
    "professionalInfo": professionalInfo,
    "jobPreference": jobPreference,
    "educationalInfo": educationalInfo,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "userId": userId,
    "createdAt": createdAt!.toIso8601String(),
    "modifiedAt": modifiedAt!.toIso8601String(),
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
    educationDetails: List<EducationDetail>.from(json["educationDetails"].map((x) => EducationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "highestQualification": highestQualification,
    "educationDetails": List<dynamic>.from(educationDetails!.map((x) => x.toJson())),
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
    this.awardsAndAchivement,
  });

  String? id;
  String? qualification;
  String? educationType;
  String? specialization;
  String? university;
  String? startDate;
  String? endDate;
  String? awardsAndAchivement;

  factory EducationDetail.fromJson(Map<String, dynamic> json) => EducationDetail(
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
    preferedLocation: List<String>.from(json["preferedLocation"].map((x) => x)),
    prefferedRole: List<String>.from(json["prefferedRole"].map((x) => x)),
    language: List<String>.from(json["language"].map((x) => x)),
    profileTitle: json["profileTitle"],
    strength: json["strength"],
    weakness: json["weakness"],
  );

  Map<String, dynamic> toJson() => {
    "preferedLocation": List<dynamic>.from(preferedLocation!.map((x) => x)),
    "prefferedRole": List<dynamic>.from(prefferedRole!.map((x) => x)),
    "language": List<dynamic>.from(language!.map((x) => x)),
    "profileTitle": profileTitle,
    "strength": strength,
    "weakness": weakness,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.name,
    this.mobile,
    this.email,
    this.gender,
    this.dob,
    this.address,
    this.state,
    this.city,
    this.pinCode,
    this.maritialStatus,
    this.aadhar,
    this.introduction,
    this.country,
  });

  String? name;
  String? mobile;
  String? email;
  String? gender;
  String? dob;
  String? address;
  String? state;
  String? city;
  int? pinCode;
  String? maritialStatus;
  String? aadhar;
  String? introduction;
  String? country;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    gender: json["gender"],
    dob: json["dob"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pinCode: json["pinCode"],
    maritialStatus: json["maritialStatus"],
    aadhar: json["Aadhar"],
    introduction: json["introduction"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "email": email,
    "gender": gender,
    "dob": dob,
    "address": address,
    "state": state,
    "city": city,
    "pinCode": pinCode,
    "maritialStatus": maritialStatus,
    "Aadhar": aadhar,
    "introduction": introduction,
    "country": country,
  };
}

class ProfessionalInfo {
  ProfessionalInfo({
    this.keySkills,
    this.totalExperience,
    this.prefferedIndustry,
    this.preferedFunction,
    this.uploadResume,
    this.jobDetails,
  });

  List<String>? keySkills;
  String? totalExperience;
  String? prefferedIndustry;
  String? preferedFunction;
  String? uploadResume;
  List<JobDetail>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) => ProfessionalInfo(
    keySkills: List<String>.from(json["keySkills"].map((x) => x)),
    totalExperience: json["totalExperience"].toString(),
    prefferedIndustry: json["prefferedIndustry"],
    preferedFunction: json["preferedFunction"],
    uploadResume: json["uploadResume"],
    jobDetails: List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "keySkills": List<dynamic>.from(keySkills!.map((x) => x)),
    "totalExperience": totalExperience,
    "prefferedIndustry": prefferedIndustry,
    "preferedFunction": preferedFunction,
    "uploadResume": uploadResume,
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
    this.paymentMethod,
    this.city,
    this.noticePeroid,
    this.jobSummary,
    this.salary,
    this.salaryType,
  });

  String? id;
  String? jobTitle;
  String? employer;
  String? startDate;
  String? endDate;
  String? icurrentlyWorkHere;
  String? paymentMethod;
  String? city;
  String? noticePeroid;
  String? jobSummary;
  int? salary;
  String? salaryType;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    employer: json["employer"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    icurrentlyWorkHere: json["icurrentlyWorkHere"],
    paymentMethod: json["paymentMethod"],
    city: json["city"],
    noticePeroid: json["noticePeroid"],
    jobSummary: json["jobSummary"],
    salary: json["Salary"],
    salaryType: json["salaryType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "employer": employer,
    "startDate": startDate,
    "endDate": endDate,
    "icurrentlyWorkHere": icurrentlyWorkHere,
    "paymentMethod": paymentMethod,
    "city": city,
    "noticePeroid": noticePeroid,
    "jobSummary": jobSummary,
    "Salary": salary,
    "salaryType": salaryType,
  };
}
