import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/DashboardStatsModel.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/services/login_services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ApplicantDetailModel.dart';

class EmployeeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Employee> employeeList = [];
  List<Employee> tempEmployeeList = [];

  List<Employee> filteredEmployeeList = [];



  getEmployeeList({EmployeeListType? listType}) async {
   EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   // String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    String endpoint = getEndpoint(listType!, _id!);
    EmployeeListServices.getEmployeeList(endpoint, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        tempEmployeeList = value.data!;
        employeeList = [];
        tempEmployeeList.forEach((element ) {
          if (listType == EmployeeListType.ACTIVE){
            if (!element.isDeleted! && element.status=="Working") {
              employeeList.add(element);
            }
        }
           else if (listType == EmployeeListType.OFFERED){
            if (!element.isDeleted! && element.status=="Offer") {
              employeeList.add(element);
            }
          }

          else if (listType == EmployeeListType.ABSCONDED) {
            if (!element.isDeleted! && element.status == "Absconded") {
              employeeList.add(element);
            }
          }
          else if (listType == EmployeeListType.RELIEVED){
            if (!element.isDeleted! && element.status=="Relieved") {
              employeeList.add(element);
            }
          }
         else{
            if (!element.isDeleted! ) {
              employeeList.add(element);
            }
          }



 //Todo i  comment   below  code for don't want reverse list
          // employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          employeeList = employeeList.toList();
          filteredEmployeeList = employeeList.toList();
          setState(() {});


        });

      }

    });
  }

  String getEndpoint(EmployeeListType listType, String _id) {
    switch (listType) {
      case EmployeeListType.ACTIVE:
        return '${API.employeeSearchList}/$_id?\$orderBy=createdAt desc&\$skip=0&\$limit=20&\$filter=(status eq "Working")';

      case EmployeeListType.OFFERED:
        return '${API.employeeSearchList}/$_id';

      case EmployeeListType.ABSCONDED:
        return '${API.employeeSearchList}/$_id?\$orderBy=createdAt desc&\$skip=0&\$limit=20&\$filter=(status eq "Absconded")';

      case EmployeeListType.RELIEVED:
        return '${API.employeeSearchList}/$_id';

      default:
        return "${API.employeeList}/$_id";
    }
  }

  DashboardStats? dashbaordData;
  getDashboardCount(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    print("DASHBOARD DATA ID ${_id}");
    LoginServices.dashboardCount("${API.dashboardCount}/$_id", scaffoldKey,context)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        dashbaordData = value;
        setState(() {});
      }
    });
  }
}

enum EmployeeListType { ACTIVE, OFFERED, ABSCONDED, RELIEVED }
