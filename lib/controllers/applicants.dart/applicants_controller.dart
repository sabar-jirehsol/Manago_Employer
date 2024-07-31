import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/services/ApplicationAgainstEmployerService.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/ApplicationAgainstEmployerFilterService.dart';

class ApplicantsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<ApplicantsDetailsData> applicantsList = [];

  final tabs = [
    Container(), Container(), Container(), Container(), Container(),
    // AddDocumentScreen()
  ];
  String? selectedCity;
  String? designationVal;

  //String? skillSetVal;
  List<String> skillSetVal = [];
  String? experience;
  String? jobTitle;
  int? minexp;
  int? maxexp;
  double? maxSalary = 0;
  double? minSalary = 0;

  resetScreen() {
    selectedCity = null;
    designationVal = null;
    //skillSetVal = null;
    experience = null;
    jobTitle = null;
    maxSalary = null;
    minSalary = null;
    formkey.currentState!.reset();
    selectedCity = '';
    designationVal = '';
    // skillSetVal='';
    skillSetVal = [];

    setState(() {});
  }

  getApplicantsAgainstEmployer() async {
    EasyLoading.show(status: 'Please wait...', dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    ApplicationAgainstEmployerService.applicationAgainstEmployer(
        "${API.applicantsAgainstEmployer}/$_id", scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        applicantsList = [];
        setState(() {});
        print(API.applicantsAgainstEmployer);
        print("APPLICATION LIST");
        applicantsList = value.data!;

        applicantsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        applicantsList = applicantsList.reversed.toList();
        setState(() {});
      }
    });
  }

  List<String>? experienceList;

  getExperienceList() async {
    // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getJobTitles(
        '${API.getExperience}',
        //'${API.getSearchJobTitles}/$_id?\$orderBy=experience asc&\$limit=500&\$apply=groupby(experience)',
        // _token!,
        scaffoldKey)
        .then((value) {
      // EasyLoading.dismiss();
      if (value != null) {
        experienceList = value;
        setState(() {});
      }
    });
  }

  List<String> citesList = [];

  getCitiesList() async {
    // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getJobTitles(
        '${API.preferredLocation}',
        //'${API.getSearchJobTitles}/$_id?\$orderBy=location asc&\$limit=500&\$apply=groupby(location)',
        // _token!,
        scaffoldKey)
        .then((value) {
      // EasyLoading.dismiss();
      if (value != null) {
        citesList = value;
        setState(() {});
      }
    });
  }

  List<String> designationList = [];

  getDesignationList() async {
    // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    // String? _token = _prefs.getString('token');
    FilterDataServices.getJobTitles(
        '${API.getFilterDesignation}/$_id',
        //'${API.getSearchJobTitles}/$_id}',//?\$orderBy=designation asc&\$limit=500&\$apply=groupby(designation)',
        //_token!,
        scaffoldKey)
        .then((value) {
      // EasyLoading.dismiss();
      if (value != null) {
        designationList = value;
        setState(() {});
      }
    });
  }

  List<String> skillSetList = [];

  getSkillsList() async {
    // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getJobTitles(
        '${API.getSkills}',
        //'${API.getSearchJobTitles}/$_id?\$orderBy=keyskills asc&\$limit=500&\$apply=groupby(keyskills)',
        //_token!,
        scaffoldKey)
        .then((value) {
      // EasyLoading.dismiss();
      if (value != null) {
        skillSetList = value;
        setState(() {});
      }
    });
  }

  // List<String> jobTitlesList = [];
  //
  // getJobTitleList() async {
  //   //EasyLoading.show(status: 'Please wait...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _token = _prefs.getString('token');
  //   String? id = _prefs.getString('employerId');
  //   FilterDataServices.getJobTitles(
  //           '${API.getSearchJobTitles}/$id?\$orderBy=jobTitle asc&\$limit=500&\$apply=groupby(jobTitle)',
  //           _token!,
  //           scaffoldKey)
  //       .then((value) {
  //    // EasyLoading.dismiss();
  //     if (value != null) {
  //       jobTitlesList = value;
  //       setState(() {});
  //     }
  //   });
  // }

  List<String> searchCitiesList = [];

  getSearchCitiesList(String value) async {
    // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String? _token = _prefs.getString('token');
    FilterDataServices.getSearchCitiesList(
        API.preferredLocation,
        value,
        scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        searchCitiesList = value;
        setState(() {});
      }
    });
  }




  applyFilter(BuildContext context) async {
      // EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
  ApplicationAgainstEmployerFilterService.applicationAgainstEmployerFilter(
  API.filterApplicant,
  _id!,
  selectedCity,
  designationVal,
  minexp,
  maxexp,
  skillSetVal,
  minSalary,
  maxSalary,
  scaffoldKey)
      .then((value) {
  // EasyLoading.dismiss();
  if (value != null) {
  applicantsList = [];
  setState(() {});

  applicantsList = value.data!;
  applicantsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  applicantsList = applicantsList.reversed.toList();
  setState(() {});
  Navigator.pop(context);
  }
  });
  }
  }
