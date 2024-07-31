import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileTwoController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? businessName;
  String? firmType;
  String? gstIn;
  String? totalStaff;
  String? turnover;

  List<String> firmArray = [];
  List<String> turnoverArray = [];
}
