

import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/AddOfferLetterModel.dart';
import 'package:manago_employer/models/JobListModel.dart';
import 'package:manago_employer/services/AddEmployeeServices.dart';
import 'package:manago_employer/services/AddOfferLetterServices.dart';
import 'package:manago_employer/services/GetAllJobsService.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/Employee_Search_Screen.dart';
import 'package:manago_employer/views/bottom_navigation/employees.dart';
import 'package:manago_employer/views/controller_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/success_dialogbox.dart';

class OfferLetterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   String?  offeredBasicSalary;
 // int? offeredBasicSalary;
  //int? offeredGrossSalary;
  String? offeredGrossSalary;
  String? note;
  String? designation;
  String? joiningDate;
  String? jobId;

  DateFormat formatter = DateFormat('dd/MM/yyyy');

  List<Datum> jobList = [];
  List<String> newJobList = [];
  String? job;
  // List<Datum> filteredUsers = List<Datum>();

  getAllJobs(BuildContext context) async {
    //BuildContext? context;
   // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    print("GET All jobs id ${_id}");
    print("${API.getAllJobsAgainstEmployer}/$_id");
    GetAllJobsServices.getAllJobss(
            "${API.getAllJobsAgainstEmployer}/$_id",  scaffoldKey,context)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        jobList = value.data!;
        newJobList = [];
        jobList.forEach((element) {
          if (!element.isDeleted!) {
            newJobList.add(element.jobTitle!);
          }
        });
        // newJobList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        // newJobList = newJobList.reversed.toList();
        // filteredUsers = newJobList;
        setState(() {});
      }
    });
  }

  getJobid(String jobTitle) {
    jobList.forEach((element) {
      if (element.jobTitle == jobTitle) {
        jobId = element.id;
        print("JOBID is ${jobId}");
      }
    });
  }

  //API implementation

  addEmployee(BuildContext context, String candidateId) async {
    //Todo i make it optional job and designation at 11-04-24 at 7:21
    // if (job == null) {
    //   Alert.showSnackbar('Job is required.', context);
    // }
    if (offeredBasicSalary == null || offeredBasicSalary == null) {
      Alert.showSnackbar('Offered Basic Salary is required.', context);
     }// else if (offeredGrossSalary == null || offeredGrossSalary == null) {
    //   Alert.showSnackbar('Offered Gross Salary is required.', context);
    // }
     else if (note == null || note!.isEmpty) {
      Alert.showSnackbar('Note is required.', context);
    }
    // else if (designation == null || designation!.isEmpty) {
    //   Alert.showSnackbar('Designation is required.', context);
    // }
    else if (joiningDate == null || joiningDate!.isEmpty) {
      Alert.showSnackbar('Joining Date is required.', context);
    } else {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
     // String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      String? _createdBy = _prefs.getString('id');
      print(candidateId);
      print(jobId);
      AddEmployeeServices.addEmployee(
              API.addEmployee,
              candidateId,
              _id!,
              jobId!,
              offeredBasicSalary!,
             // offeredGrossSalary!,
              designation!,
              note!,
              joiningDate!,
              _createdBy!,
              _createdBy,
             // _token!,
              scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          addOfferLetter(context, _id, candidateId).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ControllerScreen(
                          screenidx: 3,
                        )));
            EasyLoading.showToast('Employee added');
          });
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ControllerScreen(
          //               screenidx: 3,
          //             )));
          // EasyLoading.showToast('Employee added');
          // Navigator.of(context).pop();
        }
      });
    }
  }


  bool Appoffjoindate=false,Appoffdesignation=false,Appoffsalary=false,Appoffdescription=false;
  AddOfferLetterModel? offerLetter;
  Future<void> addOfferLetter(
      BuildContext context, String id, String candidateId) async {
    if (joiningDate == null || joiningDate!.isEmpty) {
      Appoffjoindate=true;
      //Alert.showSnackbar('Joining date is required.', context);
    } if (designation == null || designation!.isEmpty) {
      Appoffdesignation=true;
      // Alert.showSnackbar('Designation is required.', context);
    }
    if (offeredGrossSalary == null || offeredGrossSalary == null||offeredGrossSalary==0) {
      Appoffsalary=true;
      //Alert.showSnackbar('Salary is required.', context);
    }  if (note == null || note == null) {
      Appoffdescription=true;
      //Alert.showSnackbar('Salary is required.', context);
    }
    if(Appoffjoindate==false && Appoffdesignation==false && Appoffsalary==false && Appoffdescription==false)
     {
     // EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      String? _createdBy = _prefs.getString('id');
      AddOfferLetterServices.addOfferLetterService(
              API.addExperienceLetter,
              _id!,
              id,
              candidateId,
              joiningDate!,
              offeredGrossSalary!,
              designation!,
              note ?? " ",
              _createdBy!,
             // _token!,
              scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          offerLetter = value;
          print("candidateId ${value.data!.candidateId}");

          //EasyLoading.showToast('Offer Letter Added Successfully');
          //Navigator.of(context).pop();
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return FunkyOverlay(
                        imagePath: 'assets/images/tick.png',
                        message: 'OfferLetter Added successfully',
                        onTap: () {
                          Navigator.pop(context);
                        }
                    );
                  },
                ),
              );
            },
          );

        }
        else{
          print(value?.message);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                        imagePath: 'assets/images/tick.png',
                        message:'For this Applicant alredy Offer Letter released' ,
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



  // selectDate(BuildContext context, DateTime initialDateTime,
  //     {DateTime lastDate}) async {
  //   Completer completer = Completer();
  //   if (Platform.isAndroid)
  //     showDatePicker(
  //             context: context,
  //             initialDate: initialDateTime,
  //             firstDate: DateTime(1970),
  //             lastDate: lastDate == null
  //                 ? DateTime(initialDateTime.year + 10)
  //                 : lastDate)
  //         .then((temp) {
  //       if (temp == null) return null;
  //       completer.complete(temp);
  //       setState(() {});
  //     });
  //   else
  //     DatePicker.showDatePicker(
  //       context,
  //       dateFormat: 'yyyy-mmm-dd',
  //       locale: DATETIME_PICKER_LOCALE_DEFAULT,
  //       onConfirm: (temp, selectedIndex) {
  //         if (temp == null) return null;
  //         completer.complete(temp);

  //         setState(() {});
  //       },
  //     );
  //   return completer.future;
  // }
}
