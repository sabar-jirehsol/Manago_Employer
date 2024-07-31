// To parse this JSON data, do
//
//     final updateApplicationStatus = updateApplicationStatusFromJson(jsonString);

import 'dart:convert';

UpdateOfferLetterStatus updateOfferLetterStatusFromJson(String str) => UpdateOfferLetterStatus.fromJson(json.decode(str));

String updateOfferLetterStatusToJson(UpdateOfferLetterStatus data) => json.encode(data.toJson());

class UpdateOfferLetterStatus {
  UpdateOfferLetterStatus({
    this.message,
    this.employer,
  });

  String? message;
  Employer? employer;

  factory UpdateOfferLetterStatus.fromJson(Map<String, dynamic> json) => UpdateOfferLetterStatus(
    message: json["message"],
    employer: Employer.fromJson(json["employer"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "employer": employer,
  };
}

class Employer {
  Employer({
    this.ok,
    this.nModified,
    this.n,
  });

  int? ok;
  int? nModified;
  int? n;

  factory Employer.fromJson(Map<String, dynamic> json) =>Employer(
    ok: json["ok"],
    nModified: json["nModified"],
    n: json["n"],
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "nModified": nModified,
    "n": n,
  };
}
