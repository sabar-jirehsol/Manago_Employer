import 'dart:convert';

SearchCandidateModel searchCandidateModelFromJson(String str) =>
    SearchCandidateModel.fromJson(json.decode(str));

String searchCandidateModelToJson(SearchCandidateModel data) =>
    json.encode(data.toJson());

class SearchCandidateModel {
  SearchCandidateModel({
    this.data,
  }){
    print("Creating SearchCandidateModel instance...");
    print("Received data: $data");
  }

  List<SeachCandidateModelDatum>? data;

  // factory SearchCandidateModel.fromJson(Map<String, dynamic> json) {
  //   print("Parsing SearchCandidateModel from JSON...");
  //   print("Received JSON data: $json");
  //
  //
  //   return SearchCandidateModel(
  //     data: json["data"] != null
  //         ? List<SeachCandidateModelDatum>.from(json["data"].map((x) => SeachCandidateModelDatum.fromJson(x)))
  //         : null,
  //   );
  // }
  factory SearchCandidateModel.fromJson(Map<String, dynamic> json) {
    print("Parsing SearchCandidateModel from JSON...");
    print("Received JSON data: $json");

    if (json.containsKey("data")) {
      print("JSON data contains 'data' key");
      final jsonData = json["data"];
      print("Type of 'data': ${jsonData.runtimeType}");

      List<SeachCandidateModelDatum>? searchData;
      if (jsonData is List<dynamic>) {
        print("After Types od data");

        searchData = jsonData.map((datum) => SeachCandidateModelDatum.fromJson(datum)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        // Handle case where 'data' is a map instead of a list
        print("Handling 'data' as a map");
        final datum = SeachCandidateModelDatum.fromJson(jsonData);
        searchData = [datum];
      }
      print("Search data: $searchData");

      return SearchCandidateModel(data: searchData);
    } else {
      print("JSON data does not contain 'data' key");
      return SearchCandidateModel(data: null);
    }
  }



  Map<String, dynamic> toJson() => {
    "data": data != null
        ? List<dynamic>.from(data!.map((x) => x.toJson()))
        : null,

  };


}

class SeachCandidateModelDatum {
  SeachCandidateModelDatum({
    this.personalInfo,
    this.professionalInfo,
    this.educationalInfo,
    this.jobPreference,
    this.jobDetails,
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
  List<JobDetail>? jobDetails;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? modifiedAt;
  int? v;

  factory SeachCandidateModelDatum.fromJson(Map<String, dynamic> json) =>
      SeachCandidateModelDatum(
        personalInfo: json["personalInfo"] != null
            ? PersonalInfo.fromJson(json["personalInfo"])
            : null,
        professionalInfo: json["professionalInfo"] != null
            ? ProfessionalInfo.fromJson(json["professionalInfo"])
            : null,
        educationalInfo: json["educationalInfo"] != null
            ? EducationalInfo.fromJson(json["educationalInfo"])
            : null,
        jobDetails: json["jobDetails"] != null
            ? List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x)))
            : null,
        jobPreference: json["jobPreference"] != null
            ? JobPreference.fromJson(json["jobPreference"])
            : null,
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        userId: json["userId"] ?? "",
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        modifiedAt: json["modifiedAt"] != null ? DateTime.parse(json["modifiedAt"]) : null,
        v: json["__v"],
      );


  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo?.toJson(),
    "professionalInfo": professionalInfo?.toJson(),
    "educationalInfo": educationalInfo?.toJson(),
    "jobPreference": jobPreference?.toJson(),
    "jobDetails": jobDetails != null
        ? List<dynamic>.from(jobDetails!.map((x) => x?.toJson()))
        : null,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "modifiedAt": modifiedAt?.toIso8601String(),
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
        educationDetails: json["educationDetails"] != null
            ? List<EducationDetail>.from(
            json["educationDetails"].map((x) => EducationDetail.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
    "highestQualification": highestQualification,
    "educationDetails": educationDetails != null
        ? List<dynamic>.from(educationDetails!.map((x) => x.toJson()))
        : null,
  };
}

class EducationDetail {
  EducationDetail({
    this.id,
    //this.qualification,
    this.educationType,
    this.specialization,
    this.university,
    this.startDate,
    this.endDate,
    this.awardsAndAchievement,
  });

  String? id;
 // String? qualification;
  String? educationType;
  String? specialization;
  String? university;
  String? startDate;
  String? endDate;
  String? awardsAndAchievement;

  factory EducationDetail.fromJson(Map<String, dynamic> json) =>
      EducationDetail(
        id: json["_id"],
       // qualification: json["qualification"],
        educationType: json["educationType"],
        specialization: json["specialization"],
        university: json["university"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        awardsAndAchievement: json["awardsAndAchivement"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    //"qualification": qualification,
    "educationType": educationType,
    "specialization": specialization,
    "university": university,
    "startDate": startDate,
    "endDate": endDate,
    "awardsAndAchivement": awardsAndAchievement,
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

    preferredLocation: json["preferedLocation"] != null
        ? List<String>.from(json["preferedLocation"].map((x) => x))
        : null,

    preferredRole: json["prefferedRole"] != null
        ? List<String>.from(json["prefferedRole"].map((x) => x))
        : null,
    language: json["language"] != null
        ? List<String>.from(json["language"].map((x) => x))
        : null,
    profileTitle: json["profileTitle"],
    strength: json["strength"],
    weakness: json["weakness"],
  );

  Map<String, dynamic> toJson() => {
    "preferedLocation": preferredLocation != null
        ? List<dynamic>.from(preferredLocation!.map((x) => x))
        : null,
    "prefferedRole": preferredRole != null
        ? List<dynamic>.from(preferredRole!.map((x) => x))
        : null,
    "language": language != null
        ? List<dynamic>.from(language!.map((x) => x))
        : null,
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
    this.address,
    this.state,
    this.city,
    this.pinCode,
    this.dob,
    this.maritalStatus,
    this.gender,
    this.aadhar,
    this.country,
    this.introduction,
    this.profilePic,
  });

  String? name;
  String? mobile;
  String? email;
  String? address;
  String? state;
  String? city;
  int? pinCode;
  String? dob;
  String? maritalStatus;
  String? gender;
  String? aadhar;
  String? country;
  String? introduction;
  String? profilePic;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pinCode: json["pinCode"],
    dob: json["dob"],
    maritalStatus: json["maritialStatus"],
    gender: json["gender"],
    aadhar: json["Aadhar"],
    country: json["country"],
    introduction: json["introduction"],
    profilePic: json["profilePic"],
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
    "maritialStatus": maritalStatus,
    "gender": gender,
    "Aadhar": aadhar,
    "country": country,
    "introduction": introduction,
    "profilePic": profilePic,
  };
}

class ProfessionalInfo {
  ProfessionalInfo({
    this.totalExperience,
    this.keySkills,
    this.preferredIndustry,
    this.preferredFunction,
    this.jobDetails,
  });

  int? totalExperience;
  List<String>? keySkills;
  String? preferredIndustry;
  String? preferredFunction;
  List<JobDetail>? jobDetails;

  factory ProfessionalInfo.fromJson(Map<String, dynamic> json) =>
      ProfessionalInfo(
        totalExperience: json["totalExperience"],
        keySkills: json["keySkills"] != null
            ? List<String>.from(json["keySkills"].map((x) => x))
            : null,
        preferredIndustry: json["prefferedIndustry"],
        preferredFunction: json["preferedFunction"],
        jobDetails: json["jobDetails"] != null
            ? List<JobDetail>.from(
            json["jobDetails"].map((x) => JobDetail.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
    "totalExperience": totalExperience,
    "keySkills": keySkills,
    "prefferedIndustry": preferredIndustry,
    "preferedFunction": preferredFunction,
    "jobDetails": jobDetails != null
        ? List<dynamic>.from(jobDetails!.map((x) => x!.toJson()))
        : null,
  };
}

class JobDetail {
  JobDetail({
    this.id,
    this.jobTitle,
    this.employer,
    this.startDate,
    this.endDate,
    this.salary,
    this.salaryType,
    //this.jobExperience,
   // this.icurrentlyWorkHere,
    //this.paymentMethod,
    this.city,
    this.jobSummary,
  });

  String? id;
  String? jobTitle;
  String? employer;
  String? startDate;
  String? endDate;
  int? salary;
  String? salaryType;
  //dynamic jobExperience;
  //dynamic icurrentlyWorkHere;
  //dynamic paymentMethod;
  String? city;
  String? jobSummary;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    id: json["_id"] ?? "",
    jobTitle: json["jobTitle"] ?? "",
    employer: json["employer"] ?? "",
    startDate: json["startDate"] ?? "",
    endDate: json["endDate"] ?? "",
    salary: json["Salary"],
    salaryType: json["salaryType"] ?? "",
   // jobExperience: json["jobExperience"],
   // icurrentlyWorkHere: json["IcurrentlyWorkHere"],
    //paymentMethod: json["paymentMethod"],
    city: json["city"] ?? "",
    jobSummary: json["jobSummary"] ?? "",
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "employer": employer,
    "startDate": startDate,
    "endDate": endDate,
    "Salary": salary,
    "salaryType": salaryType,
    //"jobExperience": jobExperience,
    //"IcurrentlyWorkHere": icurrentlyWorkHere,
    //"paymentMethod": paymentMethod,
    "city": city,
    "jobSummary": jobSummary,
  };
}

