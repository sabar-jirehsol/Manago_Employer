// To parse this JSON data, do
//
//     final salaryAgainstEmployeeModel = salaryAgainstEmployeeModelFromJson(jsonString);

import 'dart:convert';

SalaryAgainstEmployeeModel salaryAgainstEmployeeModelFromJson(String str) =>
    SalaryAgainstEmployeeModel.fromJson(json.decode(str));

String salaryAgainstEmployeeModelToJson(SalaryAgainstEmployeeModel data) =>
    json.encode(data.toJson());

class SalaryAgainstEmployeeModel {
  SalaryAgainstEmployeeModel({
    this.message,
    this.data,
  });

  String? message;
  List<Datum>? data;

  factory SalaryAgainstEmployeeModel.fromJson(Map<String, dynamic> json) =>
      SalaryAgainstEmployeeModel(
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
    this.earning,
    this.deductions,
    this.id,
    this.salaryMonth,
    this.employeeName,
    this.employeeId,
    this.totalEarning,
    this.totalDeduction,
    this.totalSalary,
    this.v,
    this.candidateId,
  });

  Earning? earning;
  Deductions? deductions;
  String? id;
  String? salaryMonth;
  String? employeeName;
  EmployeeId? employeeId;
  String? totalEarning;
  String? totalDeduction;
  String? totalSalary;
  int? v;
  String? candidateId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        earning: Earning.fromJson(json["Earning"]),
        deductions: Deductions.fromJson(json["Deductions"]),
        id: json["_id"],
        salaryMonth: json["salaryMonth"],
        employeeName: json["employeeName"],
        employeeId: EmployeeId.fromJson(json["employeeID"]),
        totalEarning: json["totalEarning"],
        totalDeduction: json["totalDeduction"],
        totalSalary: json["totalSalary"],
        v: json["__v"],
        candidateId: json["candidateID"] == null ? null : json["candidateID"],
      );

  Map<String, dynamic> toJson() => {
        "Earning": earning,
        "Deductions": deductions,
        "_id": id,
        "salaryMonth": salaryMonth,
        "employeeName": employeeName,
        "employeeID": employeeId,
        "totalEarning": totalEarning,
        "totalDeduction": totalDeduction,
        "totalSalary": totalSalary,
        "__v": v,
        "candidateID": candidateId == null ? null : candidateId,
      };
}

class Deductions {
  Deductions({
    this.providentFundDeduction,
    this.professionalTax,
    this.loan,
  });

  int? providentFundDeduction;
  int? professionalTax;
  int? loan;

  factory Deductions.fromJson(Map<String, dynamic> json) => Deductions(
        providentFundDeduction: json["providentFundDeduction"],
        professionalTax: json["professionalTax"],
        loan: json["Loan"],
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

  int? basic;
  int? houseRentAllowance;
  int? conveyance;
  int? specialAllowance;
  int? mobile;

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
        basic: json["basic"],
        houseRentAllowance: json["houseRentAllowance"],
        conveyance: json["Conveyance"],
        specialAllowance: json["specialAllowance"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "basic": basic,
        "houseRentAllowance": houseRentAllowance,
        "Conveyance": conveyance,
        "specialAllowance": specialAllowance,
        "mobile": mobile,
      };
}

class EmployeeId {
  EmployeeId({
    this.id,
    this.designation,
    this.joiningDate,
  });

  String? id;
  String? designation;
  String? joiningDate;

  factory EmployeeId.fromJson(Map<String, dynamic> json) => EmployeeId(
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
