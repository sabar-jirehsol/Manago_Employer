import 'dart:convert';

AddSalaryModel addSalaryModelFromJson(String str) =>
    AddSalaryModel.fromJson(json.decode(str));

String addSalaryModelToJson(AddSalaryModel data) =>
    json.encode(data.toJson());

class AddSalaryModel {
  AddSalaryModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory AddSalaryModel.fromJson(Map<String, dynamic> json) =>
      AddSalaryModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.createdAt,
    this.modifiedAt,
    this.isActive,
    this.isDeleted,
    this.id,
    this.salaryMonth,
    this.employeeName,
    this.earning, // changed from Earning to earning
    this.deductions, // changed from Deductions to deductions
    this.employeeId,
    this.totalEarning,
    this.totalDeduction,
    this.totalSalary,
    this.v,
  });

  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isActive;
  bool? isDeleted;
  String? id;
  String? salaryMonth;
  String? employeeName;
  Earning? earning; // changed from Earning to earning
  Deductions? deductions; // changed from Deductions to deductions
  String? employeeId;
  String? totalEarning;
  String? totalDeduction;
  String? totalSalary;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: DateTime.parse(json["createdAt"]),
    modifiedAt: DateTime.parse(json["modifiedAt"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
    salaryMonth: json["salaryMonth"],
    employeeName: json["employeeName"],
    earning: Earning.fromJson(json["Earning"]), // changed from Earning to earning
    deductions: Deductions.fromJson(json["Deductions"]), // changed from Deductions to deductions
    employeeId: json["employeeID"],
    totalEarning: json["totalEarning"],
    totalDeduction: json["totalDeduction"],
    totalSalary: json["totalSalary"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "modifiedAt": modifiedAt?.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "_id": id,
    "salaryMonth": salaryMonth,
    "employeeName": employeeName,
    "earning": earning?.toJson(),
    "deductions": deductions?.toJson(),
    "employeeID": employeeId,
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
