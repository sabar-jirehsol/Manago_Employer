import 'package:flutter/material.dart';

class User {
  TextEditingController? employer;
  String? jobTitle;
  String? employerController;
  String? startDate;
  String? endDate;
  String? salaryController;
  String? salaryPer;
  String? payment;
  String? city;
  String? noticePeriod;
  String? jobSummary;
  bool? checkBoxValue;

  User(
      {this.employer,
      this.jobTitle,
      this.employerController,
      this.startDate,
      this.endDate,
      this.salaryController,
      this.salaryPer,
      this.payment,
      this.city,
      this.noticePeriod,
      this.jobSummary,
      this.checkBoxValue = false});
}
