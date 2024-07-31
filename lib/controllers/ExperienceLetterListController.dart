import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/OfferLetterListModel.dart';
import 'package:manago_employer/services/GetExperienceLetterServices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExperienceLetterListController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<LetterListDatum> experienceLetterList = [];
  List<LetterListDatum> tempExperienceletterList = [];

  getExperienceLetter() async {
    //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   // String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    GetExperienceLetterServices.getExperienceLetterService(
            "${API.getExperienceLetter}/$_id", scaffoldKey)
        .then((value) {
     // EasyLoading.dismiss();
      if (value != null) {
        experienceLetterList = [];
        //todo i comment  below for get rid of  reverse list
        //tempExperienceletterList = value.data!.reversed.toList();
        tempExperienceletterList = value.data!.toList();
        tempExperienceletterList.forEach((element) {
          if (!element.isDeleted!) {
            experienceLetterList.add(element);
          }
        });

        setState(() {});
      }
    });
  }
}
