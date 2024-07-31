import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';
import 'package:manago_employer/services/CandidateUpdateServices.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/Candidate_offer_letter.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/offer_letter.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPreferenceController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? profileTitle;
  String? prefferedLocation;

  String? prefferedRole;
  String? strength;
  String? weakness;
  String? prefferedJobType;
  String? shiftType;
  String? language;

  bool checkBoxValue = false;

  List<String> chipList = [];
  TextEditingController textController = TextEditingController();
  List<String> cityNames = [];
  List<String> citesList = [];
  getCitiesList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getCitiesList(API.getCityStateMap, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        citesList = value;
        setState(() {});
      }
    });
  }

  List<String> designationList = [];
  getDesignationList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    FilterDataServices.getDesignations(API.getDesignation,  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        designationList = value;
        setState(() {});
      }
    });
  }

  List<String> skillSetList = [];
  getSkillsList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getSkills, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        skillSetList = value;
        setState(() {});
      }
    });
  }

  Map<String, Object> candidateOffeLetterDetails = Map();

  List<CardView> jobdetails = [];
  List<EducationCardView> educationDetails = [];

  // skipScreen(BuildContext context, String candidateId) async {
  //   candidateOffeLetterDetails =
  //       await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => CandidateOfferLetter(
  //       hidePreviousButton: false,
  //       candidateId: candidateId,
  //       offeredBasicSalary: candidateOffeLetterDetails['offeredBasicSalary'],
  //       offeredGrossSalary: candidateOffeLetterDetails['offeredGrossSalary'],
  //       note: candidateOffeLetterDetails['note'].toString(),
  //       designation: candidateOffeLetterDetails['designation'].toString(),
  //       joiningDate: candidateOffeLetterDetails['joiningDate'].toString(),
  //     ),
  //   ));
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
  //           jobdetails,
  //
  //           //education info page
  //           userData!.educationalInfo!.highestQualification!,
  //           educationDetails,
  //           profileTitle!,
  //           chipList,
  //           prefferedRole!,
  //           prefferedJobType!,
  //           shiftType!,
  //           language!,
  //           'no data')
  //       .then((value) async {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       candidateOffeLetterDetails = await Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => CandidateOfferLetter(
  //           hidePreviousButton: false,
  //           candidateId: candidateId,
  //           offeredBasicSalary: candidateOffeLetterDetails['offeredBasicSalary'].toString(),
  //           offeredGrossSalary: candidateOffeLetterDetails['offeredGrossSalary'].toString(),
  //           note: candidateOffeLetterDetails['note'].toString(),
  //           designation: candidateOffeLetterDetails['designation'].toString(),
  //           joiningDate: candidateOffeLetterDetails['joiningDate'].toString(),
  //         ),
  //       ));
  //     }
  //   });
  // }

  CandidateData? userData;

  getCandidateDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    CandidateDetailsService.getCandidateDetails(
            '${API.getCandidateDetails}/65d88ae1115e7aa6bd0d8585',  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        setState(() {
          userData = value.data;
          profileTitle=userData!.jobPreference?.profileTitle;
          prefferedLocation=userData!.jobPreference?.preferredLocation.toString();
          prefferedRole=userData!.jobPreference?.preferredRole.toString();
          strength=userData!.jobPreference?.strength;
          weakness=userData!.jobPreference?.weakness;
          language=userData!.jobPreference?.language.toString();

          print("Jobpreference--Details");
          print("ProfileTile ${userData!.jobPreference?.profileTitle}");
          print("PrefferedLocation ${userData!.jobPreference?.preferredLocation.toString()}");
          print("PrefferedRole ${userData!.jobPreference?.preferredRole.toString()}");
          print("Strength ${userData!.jobPreference?.strength}");
          print("Weakness ${userData!.jobPreference?.weakness}");
          print("Language ${userData!.jobPreference?.language.toString()}");
        });



      }
    });
  }
}
