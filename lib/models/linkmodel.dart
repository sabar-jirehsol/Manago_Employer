// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

Subscriptioncreate citiesFromJson(String str) => Subscriptioncreate.fromJson(json.decode(str));

String citiesToJson(Subscriptioncreate data) => json.encode(data.toJson());

class Subscriptioncreate {
  Subscriptioncreate({
    this.link,
  });

  String? link;

  factory Subscriptioncreate.fromJson(Map<String, dynamic> json) => Subscriptioncreate(
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "cities":link,
  };
}
