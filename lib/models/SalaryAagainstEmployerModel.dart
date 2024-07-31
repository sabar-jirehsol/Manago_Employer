import 'dart:convert';

SalaryAgainstEmployerModel salaryAgainstEmployerModelFromJson(String str) =>
    SalaryAgainstEmployerModel.fromJson(json.decode(str));

String salaryDetailResponseToJson(SalaryAgainstEmployerModel data) =>
    json.encode(data.toJson());

class SalaryAgainstEmployerModel {
  SalaryAgainstEmployerModel({
    this.message,
    this.data,
  });

  String? message;
  List<SalaryAgainstEmployerDatum>? data;

  factory SalaryAgainstEmployerModel.fromJson(Map<String, dynamic> json) =>
      SalaryAgainstEmployerModel(
        message: json["message"],
        data: List<SalaryAgainstEmployerDatum>.from(
            json["data"].map((x) => SalaryAgainstEmployerDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SalaryAgainstEmployerDatum {
  SalaryAgainstEmployerDatum({
    this.earning,
    this.deductions,
    this.id,
    this.salaryMonth,
    this.employeeName,
    this.employeeId,
    this.candidateId,
    this.totalEarning,
    this.totalDeduction,
    this.totalSalary,
    this.v,
  });

  Earning? earning;
  Deductions? deductions;
  String? id;
  String? salaryMonth;
  String? employeeName;
  EmployeeID? employeeId;
  CandidateID? candidateId;
  String? totalEarning;
  String? totalDeduction;
  String? totalSalary;
  int? v;

  factory SalaryAgainstEmployerDatum.fromJson(Map<String, dynamic> json) =>
      SalaryAgainstEmployerDatum(
        earning: Earning.fromJson(json["Earning"]),
        deductions: Deductions.fromJson(json["Deductions"]),
        id: json["_id"],
        salaryMonth: json["salaryMonth"],
        employeeName: json["employeeName"],
        employeeId: EmployeeID.fromJson(json["employeeID"]),
        candidateId: CandidateID.fromJson(json["candidateID"]),
        totalEarning: json["totalEarning"],
        totalDeduction: json["totalDeduction"],
        totalSalary: json["totalSalary"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "Earning": earning!.toJson(),
    "Deductions": deductions!.toJson(),
    "_id": id,
    "salaryMonth": salaryMonth,
    "employeeName": employeeName,
    "employeeID": employeeId!,
    "candidateID": candidateId!.toJson(),
    "totalEarning": totalEarning,
    "totalDeduction": totalDeduction,
    "totalSalary": totalSalary,
    "__v": v,
  };
}

class Deductions {
  Deductions({
    this.providentFundDeduction,
    this.professionalTax,
    this.loan,
  });

  double? providentFundDeduction;
  double? professionalTax;
  double? loan;

  factory Deductions.fromJson(Map<String, dynamic> json) => Deductions(
    providentFundDeduction: json["providentFundDeduction"].toDouble(),
    professionalTax: json["professionalTax"].toDouble(),
    loan: json["Loan"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "providentFundDeduction": providentFundDeduction,
    "professionalTax": professionalTax,
    "Loan": loan,
  };
}

class Earning {
  Earning({
    this.basic,
    this.houseRentAllowance,
    this.conveyance,
    this.specialAllowance,
    this.mobile,

  });

  double? basic;
  double? houseRentAllowance;
  double? conveyance;
  double? specialAllowance;
  double? mobile;


  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
    basic: json["basic"].toDouble(),
    houseRentAllowance: json["houseRentAllowance"].toDouble(),
    conveyance: json["Conveyance"].toDouble(),
    specialAllowance: json["specialAllowance"].toDouble(),
    mobile: json["mobile"].toDouble(),

  );

  Map<String, dynamic> toJson() => {
    "basic": basic,
    "houseRentAllowance": houseRentAllowance,
    "Conveyance": conveyance,
    "specialAllowance": specialAllowance,
    "mobile": mobile,
  };
}

class EmployeeID {
  EmployeeID({
    this.id,
    this.designation,
    this.joiningDate,
  });

  String? id;
  String? designation;
  String? joiningDate;

  factory EmployeeID.fromJson(Map<String, dynamic> json) => EmployeeID(
    id: json["_id"],
    designation: json["Designation"],
    joiningDate: json["JoiningDate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Designation": designation,
    "JoiningDate": joiningDate,
  };
}

class CandidateID {
  CandidateID({
    this.personalInfo,
    this.id,
  });

  PersonalInfo? personalInfo;
  String? id;

  factory CandidateID.fromJson(Map<String, dynamic> json) => CandidateID(
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "personalInfo": personalInfo!.toJson(),
    "_id": id,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.mobile,
    this.dialcode,
  });

  String? mobile;
  String? dialcode;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    mobile: json["mobile"],
    dialcode:json["dial_code"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
  };
}
