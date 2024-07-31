import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/models/JobListModel.dart';
import 'package:manago_employer/services/DeleteJobService.dart';
import 'package:manago_employer/services/GetAllJobsService.dart';
import 'package:manago_employer/services/JobDetailsService.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail_controller_view.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Datum> jobList = [];
  List<Datum> newJobList = [];
  List<Datum> filteredUsers = [];

  getAllJobs(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');

    print('id == $_id');
    GetAllJobsServices.getAllJobss("${API.getAllJobsAgainstEmployer}/$_id", scaffoldKey,context)
        .then((value) {
          print('value == $value');

      EasyLoading.dismiss();
      if (value != null) {
        jobList = value.data!;
        newJobList = [];
        jobList.forEach((element) {
          if (!element.isDeleted!) {
            newJobList.add(element);
          }
        });
        newJobList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        newJobList = newJobList.reversed.toList();
        filteredUsers = newJobList;

        setState(() {});
      }
    });
  }

  // deleteJob(String id, BuildContext context) async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String _token = _prefs.getString('token');
  //   EasyLoading.show(status: 'Please wait...');
  //   DeleteJobService.deleteJob('${API.deleteJob}/$id', _token, scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       print(value);
  //       getAllJobs();
  //       setState(() {});
  //     }
  //   });
  // }
}
