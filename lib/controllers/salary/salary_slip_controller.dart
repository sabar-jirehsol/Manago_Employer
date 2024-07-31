import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/SalaryAagainstEmployerModel.dart';
import 'package:manago_employer/models/SalaryModel.dart';
import 'package:manago_employer/services/GetSalaryServices.dart';
import 'package:manago_employer/services/SalaryAgainstEmployerServices.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/DeleteJobService.dart';
import '../../utils/alert.dart';
import '../../utils/success_dialogbox.dart';

class SalarySlipController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<SalaryAgainstEmployerDatum> employerSalaryList = [];

  getSalaryAagainstEmployer() async {
   // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
    print("Salary LIst EMployees:");
    print(_id);
    SalaryAgainstEmployerServices.getSalaryAgainstEmployerService(
            "${API.getSalaryAgainstEmployer}/$_id",scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        employerSalaryList = value.data!.reversed.toList();
        print('employerSalaryList ');
        //print(employerSalaryList[0].candidateId);

        setState(() {});
      }
    });
  }

    List<SalaryModelDatum> salaryList = [];

  getSalarySlip(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   // String? _token = _prefs.getString('token');
     //String _id = _prefs.getString('candidateId');
    GetSalaryServices.getSalaryService(
            "${API.applicantSalarySlip}/$id", scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        salaryList = value.data!.reversed.toList();

        setState(() {});
      }
    });
  }





  deleteSalarySlip(String id, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    //EasyLoading.show(status: 'Please wait...');
    print("Sending Delete ID ${id}");
    DeleteJobService.deleteJob("${API.deleteSalarySlip}/$id",scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        //print(value);
        // getAllJobs();
        // setState(() {});
        //EasyLoading.showSuccess("Salary Slip Deleted",dismissOnTap: true,duration: Duration(seconds: 1));
       // Alert.showSnackbar('Salary Slip Deleted', context);
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
                      imagePath: 'assets/images/delframe.png',
                      message:'Salary Slip Deleted successfully' ,
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
    });
  }




}
