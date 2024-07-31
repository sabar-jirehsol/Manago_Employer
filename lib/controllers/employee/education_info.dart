import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';
import 'package:manago_employer/services/CandidateUpdateServices.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/job_preference_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationalInfoController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? highestQualification;
  String? educationType;
  String? specialization;
  String? school;
  String? startDate;
  String? endDate;
  String? awards;





  List<String> highestQualificationList = [
    // 'Secondary',
    // 'Higher Secondary',
    // 'Graduation',
    // 'Post Graduation',
    // 'PHD'
    "Uneducated",
    "10th",
    "12th",
    "Diploma",
    "Hotel Management",
  ];

  List<String> educationTypeList = [
    "Uneducated",
    "10th",
    "12th",
    "Diploma",
    "Hotel Management",
  ];

  selectDate(BuildContext context, DateTime initialDateTime,
      {DateTime? lastDate}) async {
    Completer completer = Completer();
    // if (Platform.isAndroid)
    showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: DateTime(1970),
      lastDate: lastDate == null
          ? DateTime(initialDateTime.year + 10)
          : lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith( colorScheme: const ColorScheme.light(
            primary:  Color(0xff1E3852),
            onPrimary: Colors.white,
            onBackground: Colors.white,
            onSurface: Color.fromARGB(255, 66, 125, 145),


          ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff054543), // button text color
              ),
            ),
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: Color(0xff1E3852),
              backgroundColor: Colors.white,
              headerForegroundColor: Colors.white,
              shape: RoundedRectangleBorder( // Set the shape to RoundedRectangleBorder
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0), // Adjust the border radius as needed
                ),
              ),
              surfaceTintColor: Colors.white,

            ),
          ),
          child: child!,
        );
      },
    )
        .then((temp) {
      if (temp == null) return null;
      completer.complete(temp);
      setState(() {});
    });
    // else
    //   DatePicker.showDatePicker(
    //     context,
    //     dateFormat: 'yyyy-mmm-dd',
    //     locale: DATETIME_PICKER_LOCALE_DEFAULT,
    //     onChange: (temp, selectedIndex) {
    //       if (temp == null) return null;
    //       completer.complete(temp);

    //       setState(() {});
    //     },
    //   );
    return completer.future;
  }

  List<EducationCardView> educations = [];

  List<CardView> jobDetails = [];

  Map<String, Object> jobPreferenceDetails = Map();

  // skipScreen(BuildContext context, String candidateId) async {
  //   jobPreferenceDetails = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => JobPreferenceScreen(
  //           jobDetails: jobDetails,
  //           educationdetails: educations,
  //           candidateId: candidateId,
  //           profileTitle: jobPreferenceDetails['profileTitle'].toString(),
  //           prefferedLocation: jobPreferenceDetails['prefferedLocation'].toString(),
  //           prefferedRole: jobPreferenceDetails['prefferedRole'].toString(),
  //           prefferedJobType: jobPreferenceDetails['prefferedJobType'].toString(),
  //           shiftType: jobPreferenceDetails['shiftType'].toString(),
  //           language: jobPreferenceDetails['language'].toString(),
  //           checkBoxValue: jobPreferenceDetails['checkBoxValue'],
  //           chipList: jobPreferenceDetails['chipList'],
  //           cityNames: jobPreferenceDetails['cityNames'],
  //         ),
  //       ));
  // }

  // updateCandidate(BuildContext context, String candidateId) async {
  //   EasyLoading.show(status: 'Please wait ...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _token = _prefs.getString('token');
  //
  //   CandidateUpdateServices.updateCandidate(
  //           API.candidateUpdate,
  //           candidateId,
  //           userData!.personalInfo!.name!,
  //           userData!.personalInfo!.mobile!,
  //           userData!.personalInfo!.email!,
  //           userData!.personalInfo!.address!,
  //           userData!.personalInfo!.state!,
  //           userData!.personalInfo!.city!,
  //           userData!.personalInfo!.pincode.toString(),
  //           userData!.personalInfo!.dob!,
  //           userData!.personalInfo!.maritalStatus!,
  //           userData!.personalInfo!.gender!,
  //           userData!.personalInfo!.aadhar!,
  //           _token!,
  //           scaffoldKey,
  //           //Professional info
  //           userData!.professionalInfo!.totalExperience!,
  //           userData!.professionalInfo!.keySkills!,
  //           userData!.professionalInfo!.preferredIndustry!,
  //           userData!.professionalInfo!.preferredFunction!,
  //           jobDetails,
  //
  //           //education info page
  //           highestQualification!,
  //           educations,
  //           '',
  //           [],
  //           '',
  //           '',
  //           '',
  //           '',
  //           '')
  //       .then((value) async {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       print(candidateId);
  //       jobPreferenceDetails = await Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => JobPreferenceScreen(
  //               jobDetails: jobDetails,
  //               educationdetails: educations,
  //               candidateId: candidateId,
  //               profileTitle: jobPreferenceDetails['profileTitle'].toString(),
  //               prefferedLocation: jobPreferenceDetails['prefferedLocation'].toString(),
  //               prefferedRole: jobPreferenceDetails['prefferedRole'].toString(),
  //               prefferedJobType: jobPreferenceDetails['prefferedJobType'].toString(),
  //               shiftType: jobPreferenceDetails['shiftType'].toString(),
  //               language: jobPreferenceDetails['language'].toString(),
  //               checkBoxValue: jobPreferenceDetails['checkBoxValue'],
  //               chipList: jobPreferenceDetails['chipList'],
  //               cityNames: jobPreferenceDetails['cityNames'],
  //             ),
  //           ));
  //     }
  //   });
  // }


  CandidateData? userData;

  getCandidateDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   // String? _token = _prefs.getString('token');
    print('EmploInfo Id:${id}');
    CandidateDetailsService.getCandidateDetails(
            '${API.getCandidateDetails}/$id',scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        setState(() {userData = value.data;
        highestQualification=userData!.educationalInfo!.highestQualification;
        educationType=userData!.educationalInfo!.educationDetails?[0].educationType;
        specialization=userData!.educationalInfo!.educationDetails?[0].specialization;

        school=userData!.educationalInfo!.educationDetails?[0].university;
        startDate=userData!.educationalInfo!.educationDetails?[0].startDate;
        endDate=userData!.educationalInfo!.educationDetails?[0].endDate;
        awards=userData!.educationalInfo!.educationDetails?[0].awardsAndAchivement;

        print("Education--Details");
        print("Highest Qualification ${userData!.educationalInfo!.highestQualification}");
        print("Education Type ${userData!.educationalInfo!.educationDetails?[0].educationType}");
        print("Specialization ${userData!.educationalInfo!.educationDetails?[0].specialization}");
        print("University ${userData!.educationalInfo!.educationDetails?[0].university}");
        print("StartDate ${userData!.educationalInfo!.educationDetails?[0].startDate}");
        print("EndDate ${userData!.educationalInfo!.educationDetails?[0].endDate}");
        print("AwardsAndachiev ${userData!.educationalInfo!.educationDetails?[0].awardsAndAchivement}"); });


      }
    });
  }
}
