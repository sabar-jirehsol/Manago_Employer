// To parse this JSON data, do
//
//     final employeeListDetailsModel = employeeListDetailsModelFromJson(jsonString);

import 'dart:convert';

EmployeeListDetailsModel employeeListDetailsModelFromJson(String str) =>
    EmployeeListDetailsModel.fromJson(json.decode(str));

String employeeListDetailsModelToJson(EmployeeListDetailsModel data) =>
    json.encode(data.toJson());

class EmployeeListDetailsModel {
  EmployeeListDetailsModel({
    this.message,
    this.data,
  });

  String? message;
  EmployeeData? data;

  factory EmployeeListDetailsModel.fromJson(Map<String, dynamic> json) =>
      EmployeeListDetailsModel(
        message: json["message"],
        data: EmployeeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class EmployeeData {
  EmployeeData({
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.userId,
    this.jobId,
    this.candidateId,
    this.employerId,
    this.offeredBasicSalary,
    this.offeredGrossSalary,
    this.designation,
    this.note,
    this.joiningDate,
    this.createdBy,
    this.modifiedBy,
    this.v,
  });

  String? status;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String?  userId;
  JobId? jobId;
  CandidateId? candidateId;
  EmployerId? employerId;
  String? offeredBasicSalary;
  String? offeredGrossSalary;
  String? designation;
  String? note;
  String? joiningDate;
  String? createdBy;
  String? modifiedBy;
  int? v;

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
    status: json["status"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    modifiedAt: json["modifiedAt"] != null ? DateTime.parse(json["modifiedAt"]) : null,
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    userId: json["userId"],
    jobId: json["jobID"] != null ? JobId.fromJson(json["jobID"]) : null,
    candidateId: json["candidateID"] != null ? CandidateId.fromJson(json["candidateID"]) : null,
    employerId: json["employerID"] != null ? EmployerId.fromJson(json["employerID"]) : null,
    offeredBasicSalary: json["OfferedBasicSalary"],
    offeredGrossSalary: json["OfferedGrossSalary"],
    designation: json["Designation"],
    note: json["Note"],
    joiningDate: json["JoiningDate"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    v: json["__v"],
  );


  Map<String, dynamic> toJson() => {
        "status": status,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
         "userId":userId,
        "jobID": jobId,
        "candidateID": candidateId,
        "employerID": employerId,
        "OfferedBasicSalary": offeredBasicSalary,
        "OfferedGrossSalary": offeredGrossSalary,
        "Designation": designation,
        "Note": note,
        "JoiningDate": joiningDate,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "__v": v,
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
    this.userId,
    this.jobTitle,
    this.designation,
    this.experience,
    this.salary,
    this.vaccancy,
    this.description,
    this.employerId,
    this.v,
  });

  List<String>? keyskills;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String?userId;
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
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
    userId:json["userId"],
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
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
         "userId":userId,
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

class CandidateId {
  CandidateId({
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

  factory CandidateId.fromJson(Map<String, dynamic> json) => CandidateId(
        personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
        professionalInfo: ProfessionalInfo.fromJson(json["professionalInfo"]),
        educationalInfo: EducationalInfo.fromJson(json["educationalInfo"]),
        jobPreference: JobPreference.fromJson(json["jobPreference"]),
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        userId:json["userId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "personalInfo": personalInfo,
        "professionalInfo": professionalInfo,
        "educationalInfo": educationalInfo,
        "jobPreference": jobPreference,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
    "userId":userId,
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
    this.startDate,
    this.endDate,
    this.passingYear,
    this.awardsAndAchivement,
    this.document,
  });

  String? id;
  String? qualification;
  String? educationType;
  String? specialization;
  String? university;
  String? startDate;
  String? endDate;
  String? passingYear;
  String? awardsAndAchivement;
  String? document;

  factory EducationDetail.fromJson(Map<String, dynamic> json) =>
      EducationDetail(
        id: json["_id"],
        qualification: json["qualification"] ?? json['educationType'],
        educationType: json["educationType"],
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
        "educationType": educationType,
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
    this.profileTitle,
    this.prefferedRole,
    this.prefferefJobType,
    this.shiftType,
    this.language,
    this.iAmSpeciallyAbled,
  });

  List<String>? preferedLocation;
  String? profileTitle;
  List<String>? prefferedRole;
  String? prefferefJobType;
  String? shiftType;
  List<String>? language;
  String? iAmSpeciallyAbled;

  factory JobPreference.fromJson(Map<String, dynamic> json) => JobPreference(
        preferedLocation:
            List<String>.from(json["preferedLocation"].map((x) => x)),
        profileTitle: json["profileTitle"],
        prefferedRole: json["prefferedRole"] != null
            ? List<String>.from(json["prefferedRole"].map((x) => x))
            : [],
        prefferefJobType: json["prefferefJobType"],
        shiftType: json["shiftType"],
        language: json["language"] != null
            ? List<String>.from(json["language"].map((x) => x))
            : [],
        iAmSpeciallyAbled: json["iAmSpeciallyAbled"],
      );

  Map<String, dynamic> toJson() => {
        "preferedLocation": List<dynamic>.from(preferedLocation!.map((x) => x)),
        "profileTitle": profileTitle,
        "prefferedRole": List<dynamic>.from(prefferedRole!.map((x) => x)),
        "prefferefJobType": prefferefJobType,
        "shiftType": shiftType,
        "language": List<dynamic>.from(language!.map((x) => x)),
        "iAmSpeciallyAbled": iAmSpeciallyAbled,
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
  String?dialcode;
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
  String?profilePic;

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
    introduction:json["introduction"],
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
    this.keySkills,
    this.totalExperience,
    this.prefferedIndustry,
    this.preferedFunction,
    this.uploadResume,
    this.jobDetails,
  });

  List<String>? keySkills;
  num? totalExperience;
  String? prefferedIndustry;
  String? preferedFunction;
  String? uploadResume;
  List<JobDetail>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) =>
      ProfessionalInfo(
        keySkills: List<String>.from(json["keySkills"].map((x) => x)),
        totalExperience: json["totalExperience"],
        prefferedIndustry: json["prefferedIndustry"],
        preferedFunction: json["preferedFunction"],
        uploadResume: json["uploadResume"],
        jobDetails: List<JobDetail>.from(
            json["jobDetails"].map((x) => JobDetail.fromJson(x))),
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
    this.Salary,
    this.salaryType,
    this.icurrentlyWorkHere,
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
  int? Salary;
  String? salaryType;
  String? icurrentlyWorkHere;
  String? paymentMethod;
  String? city;
  String? noticePeroid;
  String? jobSummary;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
        id: json["_id"],
        jobTitle: json["jobTitle"],
        employer: json["employer"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        Salary: json["Salary"],
        salaryType: json["salaryType"],
        icurrentlyWorkHere: json["IcurrentlyWorkHere"],
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
        "paymentMethod": paymentMethod,
        "city": city,
        "noticePeroid": noticePeroid,
        "jobSummary": jobSummary,
      };
}

class EmployerId {
  EmployerId({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.name,
    this.businessName,
    this.firmType,
    this.mobile,
    this.email,
    this.address,
    this.state,
    this.panNo,
    this.gstnNo,
    this.totalStaff,
    this.annualTurnover,
    this.userId,
    this.v,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? name;
  String? businessName;
  String? firmType;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? panNo;
  String? gstnNo;
  int? totalStaff;
  String? annualTurnover;
  String? userId;
  int? v;

  factory EmployerId.fromJson(Map<String, dynamic> json) => EmployerId(
        createdAt: DateTime.parse(json["createdAt"]),
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        userId:json["userId"],
        name: json["name"],
        businessName: json["businessName"],
        firmType: json["firmType"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        state: json["state"],
        panNo: json["panNo"],
        gstnNo: json["GSTNNo"],
        totalStaff: json["totalStaff"],
        annualTurnover: json["annualTurnover"],

        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "name": name,
        "businessName": businessName,
        "firmType": firmType,
        "mobile": mobile,
        "email": email,
        "address": address,
        "state": state,
        "panNo": panNo,
        "GSTNNo": gstnNo,
        "totalStaff": totalStaff,
        "annualTurnover": annualTurnover,

        "__v": v,
      };
}
