// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  Cities({
    this.cities,
  });

  List<String>? cities;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        cities: List<String>.from(json["cities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities!.map((x) => x)),
      };
}
