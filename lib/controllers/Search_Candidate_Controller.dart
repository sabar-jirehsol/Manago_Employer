import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/SearchhCandidateModel.dart';
import 'package:manago_employer/services/ApplicationAgainstEmployerService.dart';
import 'package:manago_employer/services/SearchCandidateServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/CandidateDetailsModel.dart';
import '../services/CandidateDetailsServices.dart';
import '../services/CandidateViaMobile.dart';
import 'search_candidates_result.dart';

class SearchCandidateController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<SeachCandidateModelDatum> searchCandidateData = [];

  searchCandidate(BuildContext context, String mobile) async {
    // EasyLoading.show(status: 'Please wait ...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    SearchCandidateServices.searchCanidate(
        API.searchCandidate, mobile, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        setState(() {
          print("Search Candidates   value data");
          searchCandidateData = [];
          searchCandidateData = value.data!;
        });
      }
    });
  }


  List<SeachCandidateModelDatum> pagenatedData = [];
  bool stopLoading = false;

  Future<void> searchCandidateV2(BuildContext context,
      String name,
      String mobile,
      String aadhar,
      List<String> designation,
      //String cities,
      List<String> cities,
      List<String> keySkills,
      int minExp,
      int maxExp,
      {int page = 0}) async {
    stopLoading = true;
    //EasyLoading.show(status: 'Please wait ...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    SearchCandidateServices.searchCanidateV2(
      // '${API.searchCandidateV2}?\$orderBy=createdAt desc&\$skip=0&\$limit=20',
        '${API.searchCandidateV2}',
        designation,
        cities,
        keySkills,
        minExp,
        maxExp,
        //_token!,
        scaffoldKey,
        page)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        // if (value.data.isEmpty) {
        //   // Navigator.pop(context);
        //   EasyLoading.showInfo('No Records Found');
        // } else {
        setState(() {
          // searchCandidateData = [];
          pagenatedData = value.data!;

          searchCandidateData.addAll(value.data!);
          if (value.data == null || value.data!.isEmpty) {
            stopLoading = true;
          } else {
            stopLoading = false;
          }
        });
        // }
      } else {
        // Navigator.pop(context);
        EasyLoading.showInfo('No Records Found');
      }
    });


    // applicant list
    List<ApplicantsDetailsData> applicantsList = [];

    getApplicantsAgainstEmployer() async {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      ApplicationAgainstEmployerService.applicationAgainstEmployer(
          "${API.applicantsAgainstEmployer}/$_id", scaffoldKey)
          .then((value) {
        //EasyLoading.dismiss();
        if (value != null) {
          applicantsList = [];
          setState(() {});

          applicantsList = value.data!;
          applicantsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          applicantsList = applicantsList.reversed.toList();
          setState(() {});
        }
      });
    }
  }
}