import 'package:flutter/material.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/services/ApplicantionAgainstJobService.dart';
import 'package:manago_employer/services/DeleteJobService.dart';
import 'package:manago_employer/services/JobDetailsService.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manago_employer/api/api.dart';

import '../../utils/alert.dart';
import '../../utils/success_dialogbox.dart';

class JobDetailsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  JobDetailsModel? jobDetails;
  String? date;

  dynamic getJobDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    JobDetailsService.jobDetailsService(
            '${API.jobDetails}/$id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        setState(() {
          jobDetails = value;
          date = DatePickerClass.dateFormatterMethod(value.data!.createdAt!);
          print("job details is ${jobDetails}");
          print("maxexperience is ${jobDetails!.data!.maxexperience}");
        });
        getApplicantsAgainstJob(id);
      }
    });
  }

  List<ApplicantsDetailsData> applicantsList = [];

  getApplicantsAgainstJob(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    try {
      //EasyLoading.show(status: 'Please wait...');

      ApplicationAgainstJobService.applicationAgainstJob(
              "${API.applicantsAgainstJob}/$id", scaffoldKey)
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

  deleteJob(String id, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    //EasyLoading.show(status: 'Please wait...');
    print("Sending Delete ID ${id}");
    DeleteJobService.deleteJob("${API.deleteJob}/$id",scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        //print(value);
        // getAllJobs();
        // setState(() {});
       // EasyLoading.showSuccess("Job Deleted Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context){
            return WillPopScope(
              onWillPop: () async => false,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return   FunkyOverlay(
                      imagePath: 'assets/images/delete.png',
                      message:'Job Deleted Successfully' ,
                      onTap:(){

                        Navigator.pop(context);

                      }
                  );
                },
              ),
            );
          },
        );


      }
    });
  }
}
