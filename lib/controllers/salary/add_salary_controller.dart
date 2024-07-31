import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/AddSalaryModel.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/models/SalaryAagainstEmployerModel.dart';
import 'package:manago_employer/services/AddSalaryServices.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/success_dialogbox.dart';

class AddSalaryController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? month;
  String? employee;
  String? designation;
  String? basic;
  String? hounseRentAllowance;
  String? conveyance;
  String? specialAllowance;
  String? mobile;
  String? providentFunds;
  String? professionalTax;
  String? loan;

  String? selectedEmployeeId;
  String? selectedCandidateId;


  int? Earning;
  int? Deduction;

  DateFormat formatter = DateFormat('yy-mmmm');
  List<String> employeeNamesList = [];

  getEmployeeId(String? name) {
    employeeList.forEach((element) {
      //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})"
      if ("${element.candidateId!.personalInfo!.name}-${element.designation}" ==
          employee) {
        //mobile=element.candidateId!.personalInfo!.mobile;
        selectedEmployeeId = element.id;
        designation = element.designation;
        selectedCandidateId = element.candidateId!.id;


        print("employeeId");
        print( selectedEmployeeId);
        setState(() {});
      }
    });
  }



  List<Employee> employeeList = [];

  getEmployeeList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('employerId');
//Todo  i change the  api in applicationAgainstEmployer  instead of  employeeListApi at(5.4.24 5:00PM)
    //todo if you want employeeList just replace the APi in the  section
    EmployeeListServices.getEmployeeList(
            "${API.employeeList}/$_id", scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        employeeList = value.data!;
        employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        employeeList = employeeList.reversed.toList();
        employeeList.forEach((element) {
          if (element.isDeleted == false && element.status=="Working") {
            employeeNamesList.add(
                "${element.candidateId!.personalInfo!.name}-${element.designation}");
                //"${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})");
          }
        });
        setState(() {});
      }
    });
  }


 String? m1_p,m2_p;
  AddSalaryModel? salaryDetails;
  addSalary(BuildContext context) async {
    m1_p=month?.split(' ')[0];
    m2_p=month?.split(' ')[1];
    print("split of  month and year in salary ");
    print(m2_p);
    Earning=int.parse(basic??"0")+int.parse(hounseRentAllowance??"0")+int.parse(conveyance??"0")+int.parse(specialAllowance??"0")+int.parse(mobile??"0");
    Deduction=int.parse(providentFunds??"0")+int.parse(professionalTax??'0')+int.parse(loan??"0");
    print("Earning:$Earning");
    print("Deduction:$Deduction");
     if (employee == null) {
    Alert.showSnackbar('Select employee', context);
    }
    else if (month == null || month!.isEmpty) {
      Alert.showSnackbar('Month is required', context);
    }else if (basic == null || basic!.isEmpty) {
      Alert.showSnackbar('Basic earning is required.', context);
      // } else if (hounseRentAllowance == null || hounseRentAllowance.isEmpty) {
      //   Alert.showSnackbar('House rent allowance is required.', scaffoldKey);
      // } else if (conveyance == null || conveyance.isEmpty) {
      //   Alert.showSnackbar('Conveyance is required.', scaffoldKey);
      // } else if (specialAllowance == null || specialAllowance.isEmpty) {
      //   Alert.showSnackbar('Special allowance is required', scaffoldKey);
      // } else if (mobile == null || mobile.isEmpty) {
      //   Alert.showSnackbar('Mobile earning is required.', scaffoldKey);
      // } else if (providentFunds == null || providentFunds.isEmpty) {
      //   Alert.showSnackbar('Provident funds deduction is required.', scaffoldKey);
      // } else if (professionalTax == null || professionalTax.isEmpty) {
      //   Alert.showSnackbar('Professional tax is required.', scaffoldKey);
      // } else if (loan == null || loan.isEmpty) {
      //   Alert.showSnackbar('Loan is required.', scaffoldKey);
    } else if (selectedEmployeeId == null || selectedEmployeeId!.isEmpty) {
      Alert.showSnackbar('Reselect employee.', context);
    }
    else if((Earning)!< (Deduction??0)){
      Alert.showSnackbar('Earnings must be  greater than  Deductions', context);
    }
    else {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      String? _createdBy = _prefs.getString('id');
      AddSalaryServices.addSalaryService(
              API.addSalary,
              month!,
              m2_p!,
              employee!,
              basic!,
              hounseRentAllowance ?? "0",
              conveyance ?? "0",
              specialAllowance ?? "0",
              mobile ?? "0",
              providentFunds ?? "0",
              professionalTax ?? "0",
              loan ?? "0",
              _id!,
              selectedEmployeeId!,
              selectedCandidateId!,
              _createdBy!,
              //_token!,
              scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          salaryDetails = value;
          //EasyLoading.showSuccess("Salary Added Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
         // EasyLoading.showToast('Salary Added Successfully');
          Navigator.pop(context);
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
                        imagePath: 'assets/images/tick.png',
                        message:'Salary slip  Added Successfully' ,
                        onTap:(){

                          Navigator.pop(context);

                        }
                    );
                  },
                ),
              );
            },
          );

         // Navigator.of(context).pop();
          print("Salary Added Successfully");
        }
      });
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
                    message:'Salary Slip already release for this month successfully.' ,
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
