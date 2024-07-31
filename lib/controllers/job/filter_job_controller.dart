import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/search_job_model.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/services/search_job_services.dart';
import 'package:manago_employer/views/bottom_navigation/job/filter_job_listview.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterJobController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? minSalary;
  String? maxSalary;
  String? minExpereince;
  String? maxExperience;
  String? designation;
  List<String> keySkills = [];
  List<String> city = [];

  TextEditingController textController = TextEditingController();

  List<String> keySkillsSuggestions = [
    'F&B Service',
    'Management',
    'Cooking',
    'Housekeeping',
    'Accounts',
  ];
  List<String> citesList = [];
  getCitiesList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    FilterDataServices.getCitiesList(API.getCityStateMap,  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        citesList = value;
        setState(() {});
      }
    });
  }

  //API implementation
  List<Datum> searchjobList = [];
  List<Datum> filteredUsers = [];

  searchJob(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    SearchJobServices.searchJobService(
            API.jobSearch,
            minSalary!,
            maxSalary!,
            minExpereince!,
            maxExperience!,
            designation!,
            keySkills,
            city,
            _token!,
            scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        searchjobList = [];
        value.data!.forEach((element) {
          if (!element.isDeleted!) {
            searchjobList.add(element);
          }
        });
        searchjobList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        searchjobList = searchjobList.reversed.toList();
        filteredUsers = searchjobList;

        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FilterJobListView(
            filteredUsers: filteredUsers,
            appbarTitle: 'Searched Jobs',
          ),
        ));
      }
    });
  }
}
