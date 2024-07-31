import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/models/Update_salary_model.dart';
import 'package:manago_employer/services/EmployeeListServices.dart';
import 'package:manago_employer/services/UpdateSalaryServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/salary_slip.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ApplicantDetailModel.dart';
import '../../models/SalaryAagainstEmployerModel.dart';
import '../../services/SalaryAgainstEmployerServices.dart';
import '../../utils/success_dialogbox.dart';

class EditSalaryController extends ControllerMVC {
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
  String? selectedSalaryslipId;

  DateFormat formatter = DateFormat('yy-mmmm');
  List<String> employeeNamesList = [];

  getEmployeeId(String name) {
    employeeList.forEach((element) {
      if ("${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})" ==
          employee) {
        selectedEmployeeId = element.id;
        designation = element.designation;
        selectedCandidateId = element.candidateId!.id;

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

    EmployeeListServices.getEmployeeList(
            "${API.employeeList}/$_id",scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        employeeList = value.data!;
        employeeList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        employeeList = employeeList.reversed.toList();
        employeeList.forEach((element) {
          if (element.isDeleted == false) {
            employeeNamesList.add(
                "${element.candidateId!.personalInfo!.name}(${element.candidateId!.personalInfo!.mobile})");
          }
        });
        setState(() {});
      }
    });
  }


   deleteSalary()async{
     SharedPreferences _prefs = await SharedPreferences.getInstance();
     String? _id = _prefs.getString('employerId');


   }



// double?Earning;
// double?Deduction;
//
//   UpdateSalaryModel? salaryDetails;
//   updateSalary(BuildContext context) async {
//
//
//     if (month == null || month!.isEmpty) {
//       Alert.showSnackbar('Month is required', context);
//     }
//     // } else if (employee == null) {
//     //   Alert.showSnackbar('Select employee', context);
//     // }
//     else if (basic == null || basic!.isEmpty) {
//       Alert.showSnackbar('Basic earning is required.', context);
//     }
//     else if (hounseRentAllowance == null || hounseRentAllowance!.isEmpty) {
//       hounseRentAllowance="0.0";
//       //Alert.showSnackbar('House rent allowance is required.', context);
//     }
//     else if (conveyance == null || conveyance!.isEmpty) {
//       conveyance="0.0";
//     }
//       //Alert.showSnackbar('Conveyance is required.', context);
//      else if (specialAllowance == null || specialAllowance!.isEmpty) {
//       //Alert.showSnackbar('Special allowance is required', context);
//       specialAllowance="0.0";
//     }
//
//       else if (mobile == null || mobile!.isEmpty) {
//         mobile="0.0";
//     }
//
//      else if (providentFunds == null || providentFunds!.isEmpty) {
//        providentFunds="0.0";
//     }
//
//
//     else if (professionalTax == null || professionalTax!.isEmpty) {
//       professionalTax = "0.0";
//     }
//      else if (loan == null || loan!.isEmpty) {
//      loan="0.0";
//     }
//     else if (selectedEmployeeId == null || selectedEmployeeId!.isEmpty) {
//       Alert.showSnackbar('Reselect employee.', context);
//     }
//     Earning=double.parse(basic!)+double.parse(hounseRentAllowance??"0.0")+double.parse(conveyance??"0.0")+double.parse(specialAllowance??"0.0")+double.parse(mobile??"0.0");
//     Deduction=double.parse(providentFunds??"0.0")+double.parse(professionalTax??'0.0')+double.parse(loan??"0.0");
//     else if((Earning)!< (Deduction??0)){
//       Alert.showSnackbar('Earnings must be  greater than  Deductions', context);
//     }
//     else {
//      // EasyLoading.show(status: 'Please wait...');
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//       //String? _token = _prefs.getString('token');
//       String? _id = _prefs.getString('employerId');
//       String? _createdBy = _prefs.getString('id');
//       UpdateSalaryServices.updateSalaryService(
//               API.updateSalary,
//               selectedSalaryslipId!,
//               month!,
//               employee!,
//               basic!,
//               hounseRentAllowance!,
//               conveyance!,
//               specialAllowance!,
//               mobile!,
//               providentFunds!,
//               professionalTax!,
//               loan!,
//               _id!,
//               selectedEmployeeId!,
//               selectedCandidateId!,
//               _createdBy!,
//              // _token!,
//               scaffoldKey)
//           .then((value) {
//         EasyLoading.dismiss();
//         if (value != null) {
//           salaryDetails = value;
//
//
//           //EasyLoading.showSuccess("Salary Updated Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
//
//          // EasyLoading.showToast('Salary Updated Successfully');
//           Navigator.of(context).pop();
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context){
//               return WillPopScope(
//                 onWillPop: () async => false,
//                 child: StatefulBuilder(
//                   builder: (context, setState) {
//                     return   FunkyOverlay(
//                         imagePath: 'assets/images/doc_edit.png',
//                         message:'Salary Slip Updated Successfully' ,
//                         onTap:(){
//
//                           Navigator.pop(context);
//
//                         }
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//
//         }
//       });
//     }
//   }


  double? Earning;
  double? Deduction;

  UpdateSalaryModel? salaryDetails;

  updateSalary(BuildContext context) async {
    if (month == null || month!.isEmpty) {
      Alert.showSnackbar('Month is required', context);
      return;
    }

    if (basic == null || basic!.isEmpty) {
      Alert.showSnackbar('Basic earning is required.', context);
      return;
    }

    hounseRentAllowance = hounseRentAllowance?.isEmpty ?? true ? "0.0" : hounseRentAllowance;
    conveyance = conveyance?.isEmpty ?? true ? "0.0" : conveyance;
    specialAllowance = specialAllowance?.isEmpty ?? true ? "0.0" : specialAllowance;
    mobile = mobile?.isEmpty ?? true ? "0.0" : mobile;
    providentFunds = providentFunds?.isEmpty ?? true ? "0.0" : providentFunds;
    professionalTax = professionalTax?.isEmpty ?? true ? "0.0" : professionalTax;
    loan = loan?.isEmpty ?? true ? "0.0" : loan;

    if (selectedEmployeeId == null || selectedEmployeeId!.isEmpty) {
      Alert.showSnackbar('Reselect employee.', context);
      return;
    }

    Earning = double.parse(basic!) +
        double.parse(hounseRentAllowance!) +
        double.parse(conveyance!) +
        double.parse(specialAllowance!) +
        double.parse(mobile!);

    Deduction = double.parse(providentFunds!) +
        double.parse(professionalTax!) +
        double.parse(loan!);

    if (Earning! < Deduction!) {
      Alert.showSnackbar('Earnings must be greater than Deductions', context);
      return;
    }

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _createdBy = _prefs.getString('id');

    EasyLoading.show(status: 'Please wait...');

    UpdateSalaryServices.updateSalaryService(
      API.updateSalary,
      selectedSalaryslipId!,
      month!,
      employee!,
      basic!,
      hounseRentAllowance!,
      conveyance!,
      specialAllowance!,
      mobile!,
      providentFunds!,
      professionalTax!,
      loan!,
      _id!,
      selectedEmployeeId!,
      selectedCandidateId!,
      _createdBy!,
      scaffoldKey,
    ).then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        salaryDetails = value;
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
                    imagePath: 'assets/images/doc_edit.png',
                    message: 'Salary Slip Updated Successfully',
                    onTap: () {
                      Navigator.pop(context);
                    },
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
