import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/SalaryAgainstEmployeeModel.dart';
import 'package:manago_employer/services/SalaryAgainstEmployeeServices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeSalaryslipController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Datum> employeeSalaryList = [];

  getSalaryAagainstEmployee(String id) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    SalaryAgainstEmployeeServices.getSalaryAgainstEmployeeService(
            "${API.getSalaryAgainstEmployee}/$id", scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        employeeSalaryList = value.data!.reversed.toList();

        setState(() {});
      }
    });
  }
}
