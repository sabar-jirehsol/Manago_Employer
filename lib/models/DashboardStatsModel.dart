// To parse this JSON data, do
//
//     final dashboardStats = dashboardStatsFromJson(jsonString);

import 'dart:convert';

DashboardStats dashboardStatsFromJson(String str) =>
    DashboardStats.fromJson(json.decode(str));

String dashboardStatsToJson(DashboardStats data) => json.encode(data.toJson());

class DashboardStats {
  DashboardStats(
      {this.allPostedJobs,
      this.latestPosted,
      this.activeEmployees,
      this.offeredEmployees,
      this.allApplicants,
      this.latestApplicants,
      this.abscondedEmployees,
      this.releivedEmployees,
      this.recent_offer_date,
        this.recent_relive_date,
        this.recent_absconed_date,
        this.recent_active_date,
      });

  int? allPostedJobs;
  int? latestPosted;
  int? activeEmployees;
  int? offeredEmployees;
  int? abscondedEmployees;
  int? releivedEmployees;
  int? allApplicants;
  int? latestApplicants;
  String?recent_offer_date;
  String?recent_relive_date;
  String?recent_absconed_date;
  String?recent_active_date;

  factory DashboardStats.fromJson(Map<String, dynamic> json) => DashboardStats(
        allPostedJobs: json["allPostedJobs"],
        latestPosted: json["thisweekPosted"],
        activeEmployees: json["activeEmployees"],
        abscondedEmployees: json["abscondedEmployees"],
        releivedEmployees: json["relievedEmployees"],
        offeredEmployees: json["offeredEmployees"],
        allApplicants: json["allApplicants"],
        latestApplicants: json["latestApplicants"],
      recent_offer_date:json["recent_offer_date"],
      recent_relive_date:json["recent_relive_date"],
      recent_absconed_date:json["recent_absconed_date"],
      recent_active_date:json["recent_active_date"]

      );

  Map<String, dynamic> toJson() => {
        "allPostedJobs": allPostedJobs,
        "latestPosted": latestPosted,
        "activeEmployees": activeEmployees,
        "offeredEmployees": offeredEmployees,
        "abscondedEmployees": abscondedEmployees,
        "releivedEmployees": releivedEmployees,
        "allApplicants": allApplicants,
        "latestApplicants": latestApplicants,
         "recent_offer_date":recent_offer_date,
    "recent_relive_date":recent_relive_date,
    "recent_absconed_date":recent_absconed_date,
    "recent_active_date":recent_active_date,



      };
}
