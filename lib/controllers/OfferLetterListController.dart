import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ApplicantOfferLetterModel.dart';
import 'package:manago_employer/models/OfferLetterListModel.dart';
import 'package:manago_employer/services/OfferLetterListServices.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferLetterListController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<LetterListDatum> offerLetterlist = [];
  List<LetterListDatum> tempOfferletterList = [];

  getOfferLetter(BuildContext context) async {
     //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    OfferLetterListServices.offerLetterListService(
            "${API.offerLetterList}/$_id", scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        offerLetterlist = [];
        //todo i added below line  for avoid  the  offer letter list order
        tempOfferletterList = value.data!.toList();
        //tempOfferletterList = value.data!.reversed.toList();
        tempOfferletterList.forEach((element) {
          if (!element.isDeleted!) {
            offerLetterlist.add(element);
          }
        });

        setState(() {});
      }
    });
  }

  List<ApplicantOfferLetterListDatum> applicantOfferLetterlist = [];
  List<ApplicantOfferLetterListDatum> applicantTempOfferletterList = [];

  getApplicantOfferLetter(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    // String _id = _prefs.getString('candidateId');
    OfferLetterListServices.offerLetterListService(
            "${API.offerLetterList}/$id", scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
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
}
