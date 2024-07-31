// To parse this JSON data, do
//
//     final salaryModel = salaryModelFromJson(jsonString);

import 'dart:convert';

SalaryModel salaryModelFromJson(String str) =>
    SalaryModel.fromJson(json.decode(str));

String salaryModelToJson(SalaryModel data) => json.encode(data.toJson());

class SalaryModel {
  SalaryModel({
    this.message,
    this.data,
  });

  String? message;
  List<SalaryModelDatum>? data;

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        message: json["message"],
        data: List<SalaryModelDatum>.from(json["data"].map((x) => SalaryModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SalaryModelDatum {
  SalaryModelDatum({
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
  EmployeeId? employeeId;
  String? candidateId;
  String? totalEarning;
  String? totalDeduction;
  String? totalSalary;
  int? v;

  factory SalaryModelDatum.fromJson(Map<String, dynamic> json) => SalaryModelDatum(
        earning: Earning.fromJson(json["Earning"]),
        deductions: Deductions.fromJson(json["Deductions"]),
        id: json["_id"],
        salaryMonth: json["salaryMonth"],
        employeeName: json["employeeName"],
        employeeId: EmployeeId.fromJson(json["employeeID"]),
        candidateId: json["candidateID"],
        totalEarning: json["totalEarning"],
        totalDeduction: json["totalDeduction"],
        totalSalary: json["totalSalary"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "Earning": earning,
        "Deductions": deductions,
        "_id": id,
        "salaryMonth": salaryMonth,
        "employeeName": employeeName,
        "employeeID": employeeId,
        "candidateID": candidateId,
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
