// To parse this JSON data, do
//
//     final updateApplicationStatus = updateApplicationStatusFromJson(jsonString);

import 'dart:convert';

UpdateApplicationStatus updateApplicationStatusFromJson(String str) => UpdateApplicationStatus.fromJson(json.decode(str));

String updateApplicationStatusToJson(UpdateApplicationStatus data) => json.encode(data.toJson());

class UpdateApplicationStatus {
    UpdateApplicationStatus({
        this.message,
        this.data,
    });

    String? message;
    Data? data;

    factory UpdateApplicationStatus.fromJson(Map<String, dynamic> json) => UpdateApplicationStatus(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
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
