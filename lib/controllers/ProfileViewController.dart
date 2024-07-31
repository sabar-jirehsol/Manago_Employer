import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';
import 'package:manago_employer/services/CandidateUpdateServices.dart';
import 'package:manago_employer/services/UpdateApplicationStatusService.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/offer_details.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/add_expereince.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewController extends ControllerMVC {
  String? id;
  String? status;
  String? radiovalue;
  CandidateData? userData;
  List<CardView>? _jobDetails;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  updateStatus(
    BuildContext context,
    String id,
    String status,
    String candidateId
  ) async {
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
          setState(() {
            radiovalue = status;
          });
          status == 'Offer'
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OfferDetails(id: id,candidateId: candidateId, )))
              : Navigator.pop(context);
        }
      });
    }
  }

  updateEmployeeStatus(
    BuildContext context,
    String id,
    String status,
    String jobID,
    String candidateID,
    String employerID,
    String offeredBasicSalary,
    String offeredGrossSalary,
    String designation,
    String note,
    String joiningDate,
    String createdBy,
    String modifiedBy,
  ) async {
    if (status == null || status.isEmpty) {
    } else {
      EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _token = _prefs.getString('token');
      UpdateStatusService.updateEmployeeStatus(
        API.updateEmployeeStatus,
        id,
        status,
        _token!,
        jobID,
        candidateID,
        employerID,
        offeredBasicSalary,
        offeredGrossSalary,
        designation,
        note,
        joiningDate,
        createdBy,
        modifiedBy,
      ).then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          setState(() {
            radiovalue = status;
          });
          status == 'Relieved'
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddExpereince()))
              : Navigator.pop(context);
        }
      });
    }
  }
}
