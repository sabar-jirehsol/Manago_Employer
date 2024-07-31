import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ExperinceLetterListModel.dart';
import 'package:manago_employer/models/OfferLetterListModel.dart';
import 'package:manago_employer/services/GetExperienceLetterServices.dart';
import 'package:manago_employer/services/OfferLetterListServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ExperienceLettersController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<ExperienceLetterListDatum> offerLetterlist = [];
  List<ExperienceLetterListDatum> tempOfferletterList = [];
  getExperienceLetter(String id) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    // String _id = _prefs.getString('candidateId');
    OfferLetterListServices.experienceLetterListService(
            "${API.candidateDocument}", id, _token!, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        offerLetterlist = [];
        tempOfferletterList = value.data!.reversed.toList();
        tempOfferletterList.forEach((element) {
          if (!element.isDeleted!) {
            offerLetterlist.add(element);
          }
        });

        setState(() {});
      }
    });
  }

  List<LetterListDatum> experienceLetterList = [];
  List<LetterListDatum> tempExperienceletterList = [];

  getAllExperienceLetter(String id) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    GetExperienceLetterServices.getExperienceLetterService(
            "${API.getExperienceLetter}/$_id",  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        experienceLetterList = [];
        tempExperienceletterList = value.data!.reversed.toList();
        tempExperienceletterList.forEach((element) {
          if (!element.isDeleted!) {
            if (element.candidateId!.id == id) {
              experienceLetterList.add(element);
            }
          }
        });

        setState(() {});
      }
    });
  }
}
