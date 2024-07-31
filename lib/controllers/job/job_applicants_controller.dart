import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/services/ApplicantionAgainstJobService.dart';
import 'package:manago_employer/services/UpdateApplicationStatusService.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/offer_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ApplicationDetailProfileViewModel.dart';
import '../../models/OfferLetterListModel.dart';
import '../../services/OfferLetterListServices.dart';

class JobApplicantsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? radiovalue;
  String? candidateIds;





  bool? isprofilecompletion;

  EmployerProfileCompletion(BuildContext context) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _employerUserId = _prefs.getString('employerUserId');
    ApplicationAgainstJobService.profilecompletion(
        "${API.EmployerProfileCompletion}/$_employerUserId",scaffoldKey).then((value){
      if (value!=null){
        setState((){
          isprofilecompletion=true;
          print("profile compilation check process");
          print(isprofilecompletion);
        });
      }
    });
  }




  List<ApplicantsDetailsData> applicantsList = [];

  getApplicantsAgainstJob(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    try {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);

      ApplicationAgainstJobService.applicationAgainstJob(
          "${API.applicantsAgainstJob}/$id",scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          // applicantsList = [];
          // setState(() {});
          applicantsList = value.data!;
          print(applicantsList);
          applicantsList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          applicantsList = applicantsList.reversed.toList();
          setState(() {});
          // print(applicantsList);
        } else {
          EasyLoading.dismiss();
        }
      });
    } on Exception catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
    }
  }








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











  updateStatus(BuildContext context, String id, String status,
      String candidateId,String name ) async {
    if (status == null || status.isEmpty) {
    } else {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      UpdateStatusService.updateApplicationStatus(
              API.updateApplicationStatus, id, status,scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          getApplicantsAgainstJob(id);
          setState(() {
            radiovalue = status;
          });
          status == 'Offer'
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OfferDetails(
                            id: id,
                            candidateId: candidateId,
                              name:name,
                          )))
              : Navigator.pop(context);
        }
      });
    }
  }
}
