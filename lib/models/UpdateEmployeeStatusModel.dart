//`To parse this JSON data, do
//
//     final UpdateEmployeeStatus = UpdateEmployeeStatusFromJson(jsonString);

import 'dart:convert';

UpdateEmployeeStatus updateEmployeeStatusFromJson(String str) => UpdateEmployeeStatus.fromJson(json.decode(str));

String updateEmployeeStatusToJson(UpdateEmployeeStatus data) => json.encode(data.toJson());

class UpdateEmployeeStatus {
    UpdateEmployeeStatus({
        this.message,
        this.employer,
    });

    String? message;
    Data? employer;

    factory UpdateEmployeeStatus.fromJson(Map<String, dynamic> json) => UpdateEmployeeStatus(
        message: json["message"],
        employer: Data.fromJson(json["employer"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": employer,
    };
}

class Data {
    Data({
        this.ok,
        this.nModified,
        this.n,
    });

    int? ok;
    int? nModified;
    int? n;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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