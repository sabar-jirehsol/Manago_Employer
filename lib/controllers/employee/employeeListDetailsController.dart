import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';
import 'package:manago_employer/services/DeleteEmployeeServices.dart';
import 'package:manago_employer/services/DeleteJobService.dart';
import 'package:manago_employer/services/EmployeeListDetailsServices.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manago_employer/api/api.dart';

import '../../models/ApplicationDetailProfileViewModel.dart';
import '../../services/ApplicantionAgainstJobService.dart';
import '../../services/UpdateOfferLetterStatusService.dart';

class EmployeeListDetailsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? radiovalue='Active';
  EmployeeData? employeeDetails;
  String? date;

  void getEmployeeListDetails(String id) async {
   // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    EmployeeListDetailsServices.getEmployeeListDetails(
            '${API.employeeListDetails}/$id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        setState(() {
          employeeDetails = value.data;
          if(value.data?.status=="Working"){
            radiovalue='Working';
          }else{radiovalue=value.data?.status;}

          date = DatePickerClass.dateFormatterMethod(value.data!.createdAt!);
        });
      }
    });
  }

  // List<Datum> jobList = List<Datum>();

  // getAllJobs() async {
  //   EasyLoading.show(status: 'Please wait...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String _token = _prefs.getString('token');
  //   GetAllJobsServices.getAllJobs(
  //           API.getAllJobsAgainstEmployer, _token, scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       jobList = value.data;
  //       jobList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  //       jobList = jobList.reversed.toList();
  //       setState(() {});
  //     }
  //   });
  // }

  ApplicantsDetailsProdileViewData? applicants_profileviewList;

  getApplicantsProfile(String User_id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    //String? _token = _prefs.getString('token');
    try {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);

      ApplicationAgainstJobService.applicationProfileView(
          "${API.applicantsProfileView}/$User_id",scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          // applicantsList = [];
          // setState(() {});
          applicants_profileviewList = value.data!;
          print(applicants_profileviewList);
          // applicants_profileviewList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          //applicants_profileviewList = applicants_profileviewList.reversed.toList();
          setState(() {});
          print("profileview controller view for applicants");

        } else {
          EasyLoading.dismiss();
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
    }
  }

  deleteEmployee(String id, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    EasyLoading.show(status: 'Please wait...');
    DeleteEmployeeService.deleteEmployeeService(
            '${API.employeeDelete}/$id', _token!, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        // getAllJobs();
        // setState(() {});
        Navigator.of(context).pop();
      }
    });
  }




  updateActivetoAbscondStatus(BuildContext context, String id, String status,
      ) async {
    if (status == null || status.isEmpty) {
    } else {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      UpdateOfferletterStatusService.updateOfferletterStatus(
          API.updateOfferLetterStatus, id, status,scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          print("VALLLUUEE${value}");
          //getApplicantsAgainstJob(id);
          setState(() {
            radiovalue = status;
          });
          // status == 'Offer'
          //     ? Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OfferDetails(
          //           // id: id,
          //           // candidateId: candidateId,
          //         )))
          //     : Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    }
  }





}
