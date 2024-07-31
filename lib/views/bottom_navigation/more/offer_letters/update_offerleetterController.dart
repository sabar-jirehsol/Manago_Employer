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
import '../../../../utils/success_dialogbox.dart';

class UpdateOfferletterController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String?offerletterId;
  String? employee;
  String? businessName;
  String? joiningDate;
  String? description;
  String? designation;
  //int? salary;
  String? salary;

  DateFormat formatter = DateFormat('yy-mmmm');

  // List<Employee> employeeList = [];



bool update_offbusinessname=false,update_offjoininDate=false,update_designation=false,update_offsalary=false,update_offdescription=false;



  TextEditingController textController = TextEditingController();

  updateOfferletter(BuildContext context) async {
    // if (businessName == null || businessName!.isEmpty) {
    //   update_offbusinessname=true;
    //   //Alert.showSnackbar('Business Name should not be null', context);
    // }
    if (joiningDate == null || joiningDate!.isEmpty) {
      update_offjoininDate=true;
      //Alert.showSnackbar('JoiningDate should not be empty.', context);
    }  if (designation == null||designation!.isEmpty) {
      update_designation=true;
     // Alert.showSnackbar('Designation should not be empty', context);
    } if (salary == null||salary == 0) {
      update_offsalary=true;
      //Alert.showSnackbar('Salary is Required and it should not be 0 ', context);
    }   if (description == null || description!.isEmpty) {
      update_offdescription=true;
      //Alert.showSnackbar('Description should not be empty', context);
    }
    if( update_offjoininDate==false && update_designation==false &&update_offsalary==false &&update_offdescription==false) {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _createdBy = _prefs.getString('id');
      print("send for updating");
      print(businessName);
      print(joiningDate);
      print(designation);
      print(salary);
      print(description);
      UpdateOfferLetterServices.updateOfferLetterService(
          API.updateOfferletter,
          offerletterId!,
          employerId!,
          employeeId!,
          candidateId!,
          joiningDate!,
          salary!,
          designation!,
          description ?? " ",
          _createdBy!,
          //_token!,
          scaffoldKey
      )
          .then((value) {
        //EasyLoading.dismiss();
        if (value != null) {
          //EasyLoading.showSuccess("Offer Letter Updated Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
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
                        message:'Offer letter Updated Successfully' ,
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
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    //TOdo  already commented  the below by noone.
    // mobileNumber = _prefs.getString('mobile');

    print("offerdetails Uodate id ${id}");
    OfferLetterDetailsServices.offerLetterDetailsService(
        '${API.offerLetterDetails}/$id', scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        print(value.message);
        //userData = value.data![0];
        userData = value.data![0];
        businessName=userData!.employerId!.businessName;
        joiningDate=userData!.joiningDate;
        designation=userData!.designation;
        salary=userData!.offeredSalary.toString();
        description=userData!.description;
        id=userData!.id!;
        offerletterId=userData!.id;
        employerId=userData!.employerId!.id;
        employeeId=userData!.employeeId;
        candidateId=userData!.candidateId!.id;


        print(value.data![0].designation);
        setState(() {});
      }
    });
  }

}
