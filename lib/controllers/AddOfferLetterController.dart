import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/AddOfferLetterModel.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/services/AddOfferLetterServices.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

import '../models/ApplicantDetailModel.dart';
import '../services/ApplicantionAgainstJobService.dart';
import '../utils/success_dialogbox.dart';

class AddOfferLetterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? applicationId;
  String? employee;
  String? joiningDate;
  String? description;
  String? designation;
  //int? salary;
  String? salary;

  DateFormat formatter = DateFormat('yy-mmmm');

  // List<Employee> employeeList = [];
  List< ApplicantsDetailsData> employeeList = [];

  getEmployeeList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');


    //Todo  i change the  api in applicationAgainstEmployer  instead of  employeeListApi at(5.4.24 5:00PM)
    //todo if you want employeeList just replace the APi in the  section
    EmployeeListServices.getApplicantsList(
            "${API.applicantsAgainstEmployer}/$_id", scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        employeeList = value.data!;

        employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        employeeList = employeeList.reversed.toList();
        employeeList.forEach((element) {
          if (element.isDeleted == false) {
            employeeNamesList.add(
                "${element.candidateId!.personalInfo!.name}-${element.jobId!.designation}");

                 //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})");
            print("EMPLoyeeNAme list");
            print(employeeNamesList);

          }
        });
        setState(() {});
      }
    });
  }

  bool? isprofilecompletion=false;

  EmployerProfileCompletion(BuildContext context) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _employerUserId = _prefs.getString('employerUserId');
    ApplicationAgainstJobService.profilecompletion(
        "${API.EmployerProfileCompletion}/$_employerUserId",scaffoldKey).then((value){
      if (value!=null){
        setState((){
          isprofilecompletion=true;
        });
      }
    });
  }



  String? selectedEmployeeId;
  String? selectedCandidateId;
  String? selectedExperienceLetterId;

  List<String> employeeNamesList = [];
  List<String> employeeIdList = [];
  List<String> employeeDesignationList = [];
  getEmployeeId(String? name) {
    employeeList.forEach((element) {

      print("ADD OFFER letter desgnation");
      print(employee);
      print("Designation");
      print(designation);
      print("EmployeeId");
      print(selectedEmployeeId);
      print(element.candidateId!.personalInfo!.name);

      //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})"
      if ("${element.candidateId!.personalInfo!.name}-${element.jobId!.designation}" ==
          employee) {
        print(selectedEmployeeId);
        selectedEmployeeId = element.id;
        designation = element.jobId!.designation;
        //joiningDate = element.joiningDate;
       // salary = element.offeredBasicSalary;
        selectedCandidateId = element.candidateId!.id;

        setState(() {});
      }
    });
  }


  bool offemp=false,offjoindate=false,offdesignation=false,offsalary=false,offdescription=false;



  AddOfferLetterModel? offerLetter;
  addOfferLetter(BuildContext context) async {

    if (employee == null || employee!.isEmpty) {
      offemp=true;
      //Alert.showSnackbar('Employee is required', context);
    }  if (joiningDate == null || joiningDate!.isEmpty) {
      offjoindate=true;
      //Alert.showSnackbar('Joining date is required.', context);
    }  if (designation == null || designation!.length==0) {
      offdesignation=true;
     // Alert.showSnackbar('Designation is required.', context);
    }  if (salary == null ||salary==0) {
      offsalary=true;
      //Alert.showSnackbar('Salary is required.', context);
    }  if (description == null || description!.isEmpty) {
      offdescription=true;
      //Alert.showSnackbar('Salary is required.', context);
    }
      if(offemp==false &&offjoindate==false && offdesignation==false && offsalary==false && offdescription==false)
     {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      String? _createdBy = _prefs.getString('id');
      AddOfferLetterServices.addOfferLetterService(
              API.addExperienceLetter,
              _id!,
              selectedEmployeeId!,
              selectedCandidateId!,
              joiningDate!,
              salary!,
              designation!,
              description ?? " ",
              _createdBy!,
              //_token!,
              scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        print("sfdhhdskfhkdshfkshdfk");
        print(value?.message);
        if (value != null) {
          offerLetter = value;
          //EasyLoading.showSuccess("Offer Letter Added Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
          //EasyLoading.showToast('Offer Letter Added Successfully');
          setState((){});
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
                        imagePath: 'assets/images/tick.png',
                        message:'OfferLetter Added Successfully' ,
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
     // Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
              builder: (context, setState) {
                return   FunkyOverlay(
                    imagePath: 'assets/images/exc_markk.png',
                    message:'For this Applicant already Offer Letter released' ,
                    text_color: Colors.red,
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
  }


}
