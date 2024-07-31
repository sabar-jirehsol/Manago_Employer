import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/services/JobDetailsService.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/services/UpdateJobServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail_controller_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/EmployeeListModel.dart';
import '../../../../models/OfferLetterDetailsModel.dart';
import '../../../../services/AddOfferLetterServices.dart';
import '../../../../services/OfferLetterDetailsServices.dart';
import '../../../../services/UpdateOfferLetterServices.dart';
import '../../services/UpdateExperienceLetterServices.dart';
import '../../utils/success_dialogbox.dart';

class UpdateExperienceletterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? expletterId;
  String? employee;
  String? joiningDate;
  DateTime?release_joinDate;
  String? releasingDate;
  String? description;
  String? designation;
  //int? salary;
  //String? salary;

  DateFormat formatter = DateFormat('yy-mmmm');

  // List<Employee> employeeList = [];





  bool update_expemp=false,update_expjoindate=false,update_expreleasingdate=false,update_expdesignation=false,update_expdescription=false;

  TextEditingController textController = TextEditingController();

  updateExperienceletter(BuildContext context) async {
    // if (businessName == null || businessName!.isEmpty) {
    //   Alert.showSnackbar('Business Name should not be null', context);
    // }
     if (joiningDate == null || joiningDate!.isEmpty) {
       update_expjoindate=true;
      //Alert.showSnackbar('JoiningDate should not be empty.', context);
    }  if (releasingDate == null||releasingDate!.isEmpty) {
       update_expreleasingdate=true;
       //Alert.showSnackbar('ReleasingDate should not be empty', context);
     }
     if (description == null || description!.isEmpty) {
       update_expdescription=true;
     }
     if (designation == null||designation!.isEmpty) {
       update_expdesignation = true;

     }

     //Alert.showSnackbar('Designation should not be empty', context);
    // }  if (salary == 0) {
    //   Alert.showSnackbar('Salary should not be empty', context);
    // // } else if (salary == null) {
    // //   Alert.showSnackbar('Salary should not be empty', context);
    //  }
    //Alert.showSnackbar('Description should not be empty', context);

     if(update_expjoindate==false && update_expreleasingdate==false && update_expdescription ==false && update_expdesignation ==false)
      {
      //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _createdBy = _prefs.getString('id');
      print("send for updating");

      print(joiningDate);
      print(designation);
      //print(salary);
      print(description);
      UpdateExperienceLetterServices.updateExperienceLetterService(
          API.updateOfferletter,
          expletterId!,
          employerId!,
          employeeId!,
          candidateId!,
          joiningDate!,
          releasingDate!,
          //salary!,
          designation!,
          description ?? " ",
          _createdBy!,
          //_token!,
          scaffoldKey
      )
          .then((value) {
       // EasyLoading.dismiss();
        if (value != null) {
          //EasyLoading.showSuccess("Experience Letter Updated Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
         // EasyLoading.showToast('Salary Updated Successfully');

          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                        imagePath: 'assets/images/doc_edit.png',
                        message:'Experience Letter Updated Successfully' ,
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

  OfferLetterDatum? userData;
  String? id;
  String? employerId;
  String? employeeId;
  String? candidateId;

  offerLetterDetails(String id) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    //TOdo  already commented  the below by noone.
    // mobileNumber = _prefs.getString('mobile');

    print("offerdetails Uodate id ${id}");
    OfferLetterDetailsServices.offerLetterDetailsService(
        '${API.offerLetterDetails}/$id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        print(value.message);
        //userData = value.data![0];
        userData = value.data![0];

        joiningDate=userData!.joiningDate;
        releasingDate=userData!.relivingDate;
        designation=userData!.designation;
        //salary=userData!.offeredSalary.toString();
        description=userData!.description;
        id=userData!.id!;
        expletterId=userData!.id!;
        employerId=userData!.employerId!.id;
        employeeId=userData!.employeeId;
        candidateId=userData!.candidateId!.id;

        parseJoiningDate(joiningDate!);
        print(value.data![0].designation);
        setState(() {});
      }
    });
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

}