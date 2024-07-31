// To parse this JSON data, do
//
//     final stateCityModel = stateCityModelFromJson(jsonString);

import 'dart:convert';

StateCityModel stateCityModelFromJson(String str) =>
    StateCityModel.fromJson(json.decode(str));

String stateCityModelToJson(StateCityModel data) => json.encode(data.toJson());

class StateCityModel {
  StateCityModel({
    this.india,
  });

  List<India>? india;

  factory StateCityModel.fromJson(Map<String, dynamic> json) => StateCityModel(
        india: List<India>.from(json["india"].map((x) => India.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "india": List<dynamic>.from(india!.map((x) => x.toJson())),
      };
}

class India {
  India({
    this.cities,
    this.id,
    this.state,
  });

  List<String>? cities;
  String? id;
  String? state;

  factory India.fromJson(Map<String, dynamic> json) => India(
        cities: List<String>.from(json["cities"].map((x) => x)),
        id: json["_id"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities!.map((x) => x)),
        "_id": id,
        "state": state,
      };
}
