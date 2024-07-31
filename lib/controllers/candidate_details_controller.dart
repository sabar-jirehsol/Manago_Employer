import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/models/SearchhCandidateModel.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidateDetailsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<SeachCandidateModelDatum> searchCandidateData =[];

  CandidateData? userData;

  getCandidateDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');

    CandidateDetailsService.getCandidateDetails(
            '${API.getCandidateDetails}/$id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        userData = value.data;
        print("keyskills");
        print('${userData!.professionalInfo!.keySkills!}');
        //print("currentlyworking here ${userData!.professionalInfo!.jobDetails![0].currentlyWorkHere}");
      }
      setState(() {});
    });
  }
}
