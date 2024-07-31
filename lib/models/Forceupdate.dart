// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

Forceupdate forceupdateFromJson(String str) =>
    Forceupdate.fromJson(json.decode(str));


class Forceupdate {
  Forceupdate({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory Forceupdate.fromJson(Map<String, dynamic> json) => Forceupdate(
    data: Data.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}

class Data {
  Data({

    this.verson
  });

Apiverson? verson;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        verson: Apiverson.fromJson(json['apiVersion'])
  );

  Map<String, dynamic> toJson() => {
    "apiVersion": verson,
  };
}
class Apiverson {

  Apiverson({
    this.jobSeeker,
    this.employer,

  });

  String? jobSeeker;
  String? employer;


  factory Apiverson.fromJson(Map<String, dynamic> json) => Apiverson(
      jobSeeker: json['jobSeeker'],
      employer: json["employer"],

  );

  Map<String, dynamic> toJson() => {
    "jobSeeker": jobSeeker,
    "employer": employer,

  };
}
