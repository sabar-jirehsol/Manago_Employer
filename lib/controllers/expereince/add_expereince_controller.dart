import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/AddExperienceLetterModal.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/services/AddEmployeeServices.dart';
import 'package:manago_employer/services/AddExperienceLetterServices.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/success_dialogbox.dart';

class AddExpereinceController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? employee;
  String? joiningDate;
  DateTime?release_joinDate;
  String? releasingDate;
  String? description;
  String? designation;

  //int? salary;
  String? salary;

  DateFormat formatter = DateFormat('yy-mmmm');

  List<Employee> employeeList = [];

  getEmployeeList() async {
    //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');


    //Todo  i change the  api in applicationAgainstEmployer  instead of  employeeListApi at(8.4.24 :00PM)
    //todo if you want employeeList just replace the APi in the  section
    EmployeeListServices.getEmployeeList(
        "${API.employeeList}/$_id", scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        employeeList = value.data!;
        employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        employeeList = employeeList.reversed.toList();
        employeeList.forEach((element) {
          if (element.isDeleted == false&& element.status=="Working") {
            employeeNamesList.add(
                "${element.candidateId!.personalInfo!.name}");
            //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})");
          }
        });
        setState(() {});
      }
    });
  }

  String? selectedEmployeeId;
  String? selectedCandidateId;
  String? selectedExperienceLetterId;

  List<String> employeeNamesList = [];

  getEmployeeId(String name) {
    employeeList.forEach((element) {
      //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})"
      if ("${element.candidateId!.personalInfo!.name}" ==
          employee) {
        selectedEmployeeId = element.id;
        designation = element.designation;
        selectedCandidateId = element.candidateId!.id;
        joiningDate = element.joiningDate;
        salary = element.offeredBasicSalary;

        setState(() {});
       parseJoiningDate(joiningDate!);
       // For debugging, remove or modify as needed

      }

    }
    );
  }
  DateTime parseJoiningDate(String dateString) {
    try {
      DateFormat dateFormat = DateFormat('dd/MM/yy');
      DateTime joiningDate = dateFormat.parse(dateString);

      // Adjust the year if it's in the format 'yy' (e.g., '24' should become '2024')
      if (joiningDate.year < 100) {
        joiningDate = DateTime(joiningDate.year + 2000, joiningDate.month, joiningDate.day);
      }

      release_joinDate=joiningDate;
      print("Function date format ${release_joinDate}");
      return joiningDate;
    } catch (e) {
      throw FormatException('Invalid date format: $dateString');
    }
  }

  bool expemp = false,
      expjoindate = false,
      expreleasingdate = false,
      expdesignation = false,
      expsalary = false,
      expdescription = false;

  AddExperienceLetterModel? experienceLetter;

  addExperienceLetter(BuildContext context) async {
    if (employee == null || employee!.isEmpty) {
      expemp = true;
      //Alert.showSnackbar('Employee is required', context);
    }
    if (joiningDate == null || joiningDate!.isEmpty) {
      expjoindate = true;
      // Alert.showSnackbar('Joining date is required.', context);
    }
    if (releasingDate == null || releasingDate!.isEmpty) {
      expreleasingdate = true;
      //Alert.showSnackbar('Relieving date is required.', context);
    }
    if (description == null || description!.isEmpty) {
      expdescription = true;
      //Alert.showSnackbar('Description is required.', context);
    }
    if (designation == null || designation!.isEmpty) {
      expdesignation = true;
    }
    //Alert.showSnackbar('Designation is required.', context);}
    // } else if (salary == null || salary == null) {
    //   Alert.showSnackbar('Salary is required.', context);
    // } else {
    //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    if (expemp == false && expjoindate == false && expreleasingdate == false &&
        expdescription == false && expdesignation == false) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      String? _createdBy = _prefs.getString('id');
      AddExperienceLetterServices.addExperienceLetterService(
          API.addExperienceLetter,
          _id!,
          selectedEmployeeId!,
          selectedCandidateId!,
          joiningDate!,
          releasingDate!,
          //salary! ,
          designation!,
          description!,
          _createdBy!,

          scaffoldKey)
          .then((value) {
        //EasyLoading.dismiss();
        if (value != null) {
          experienceLetter = value;
          // EasyLoading.showSuccess(
          //     "Experience Letter Added Successfully", dismissOnTap: true,
          //     duration: Duration(seconds: 2));
          //EasyLoading.showToast('Salary Added Successfully');
          //Navigator.of(context).pop();
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
                        imagePath: 'assets/images/tick.png',
                        message:'Experience Letter Added Successfully' ,
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
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context){
    //     return WillPopScope(
    //       onWillPop: () async => false,
    //       child: StatefulBuilder(
    //         builder: (context, setState) {
    //           return   FunkyOverlay(
    //               imagePath: 'assets/images/tick.png',
    //               message:'Experience Letter has been given Already Successfully' ,
    //               onTap:(){
    //
    //                 Navigator.pop(context);
    //
    //               }
    //           );
    //         },
    //       ),
    //     );
    //   },
    // );
  }

}