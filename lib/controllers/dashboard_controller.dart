import 'dart:convert';
import 'dart:developer';
//import 'dart:js';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/ApiClient.dart';
import 'package:manago_employer/api/Resource.dart';
import 'package:manago_employer/api/Status.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/DashboardStatsModel.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/models/Forceupdate.dart';
import 'package:manago_employer/models/JobListModel.dart';
import 'package:manago_employer/services/ApplicationAgainstEmployerService.dart';
import 'package:manago_employer/services/EmployeeDetailsService.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/services/Forceupdateservice.dart';
import 'package:manago_employer/services/GetAllJobsService.dart';
import 'package:manago_employer/services/login_services.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class dashboardController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Datum> jobList = [];
  List<Datum> newJobList = [];
  Data? forceupdate;

  getupdateservice() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    ForceupdateServices.getAllupdate(API.forceupdate, scaffoldKey)
        .then((value) {
      if (value != null) {
        forceupdate = value.data;

        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: forceupdate!.verson!.employer!);

        setState(() {});
      }
    });



    // ForceupdateServices.getAllJobs(
    //     "${API.getAllJobsAgainstEmployer}/$_id", _token, scaffoldKey)
    //     .then((value) {
    //   EasyLoading.dismiss();
    //   if (value != null) {
    //     jobList = value.data;
    //     newJobList = [];
    //     jobList.forEach((element) {
    //       if (!element.isDeleted) {
    //         newJobList.add(element);
    //       }
    //     });
    //     newJobList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    //     newJobList = newJobList.reversed.toList();
    //
    //     setState(() {});
    //   }
    // });
  }

  getAllJobs(BuildContext context) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    GetAllJobsServices.getAllJobss("${API.getAllJobsAgainstEmployer}/$_id",  scaffoldKey, context)
        .then((value) {
      if (value != null) {
        EasyLoading.dismiss();

        jobList = value.data!;
        newJobList = [];
        jobList.forEach((element) {
          if (!element.isDeleted!) {
            newJobList.add(element);
          }
        });
        newJobList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        newJobList = newJobList.reversed.toList();

        setState(() {});
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  // applicant list
  List<ApplicantsDetailsData> applicantsList = [];

  // void forceupdate() async
  // {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   final _response = await ApiClient.getupdate(
  //       url: API.forceupdate
  //
  //   );
  //
  //   String job= _response.data.verson.jobSeeker;
  //        Fluttertoast.showToast(msg: job);
  //
  //   // if (_response.status == STATUS.SUCCESS) {
  //   //   try {
  //   //
  //   //
  //   //
  //   //     String emp=jsonResponse.data.verson.employer;
  //   //     String jobseeker=jsonResponse.data.verson.jobSeeker;
  //   //     Fluttertoast.showToast(msg: emp);
  //   //
  //   //     // Directory tempDir = Directory('/storage/emulated/0/Download');
  //   //     // String tempPath = tempDir.path;
  //   //     // File file = new File('$tempPath/Trial_balance.xlsx');
  //   //     // await file.writeAsBytes(_response.data) as File;
  //   //     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardPage(names:names)), (route) => false);
  //   //   } catch (ex) {
  //   //     print(ex);
  //   //   }
  //   // } else {
  //   //
  //   //   print(_response.data);
  //   //   print(_response.message);
  //   //   // Fluttertoast.showToast(
  //   //   //     msg:_response.data,
  //   //   //     toastLength: Toast.LENGTH_SHORT,
  //   //   //     gravity: ToastGravity.CENTER,
  //   //   //     timeInSecForIosWeb: 1,
  //   //   //     backgroundColor: Colors.red,
  //   //   //     textColor: Colors.white,
  //   //   //     fontSize: 16.0
  //   //   // );
  //   // }
  // }

  getApplicantsAgainstEmployer() async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    ApplicationAgainstEmployerService.applicationAgainstEmployer(
            "${API.applicantsAgainstEmployer}/$_id",scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
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

  List<Employee> filteredEmployeeList = [];
  List<Employee> employeeList = [];
  List<Employee> tempEmployeeList = [];

  getEmployeeList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    EmployeeListServices.getEmployeeList(
            "${API.employeeList}/$_id",  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        tempEmployeeList = value.data!;
        employeeList = [];
        tempEmployeeList.forEach((element) {
          if (!element.isDeleted!) {
            employeeList.add(element);
          }
        });
        employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        employeeList = employeeList.reversed.toList();
        filteredEmployeeList = employeeList;
        setState(() {});
      }
    });
  }

  getUserDetails() async {
    //EasyLoading.show(status: "Please wait...");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _employeeID = _prefs.getString('employerId');
    String? _employerUserId = _prefs.getString('employerUserId');
    EmployeeDetailsService.getEmployeeDetails(
            '${API.employeeByUserId}/$_employerUserId',scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        _prefs.setString('userName', value.data!.name ?? ' ');
        _prefs.setString('profilePic', value.data!.profilepic ?? ' ');
        setState(() {});
      }
    });
  }

  DashboardStats? dashbaordData;
  getDashboardCount(BuildContext context) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    LoginServices.dashboardCount("${API.dashboardCount}/$_id", scaffoldKey,context)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        dashbaordData = value;
 print("offered count${dashbaordData?.offeredEmployees}");
        setState(() {});
      }
    });
  }
}
