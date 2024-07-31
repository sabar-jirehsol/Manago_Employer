import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/models/city_modal.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';
import 'package:manago_employer/services/CandidateUpdateServices.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/education_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessionalInfoController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? experienceYears;
  String? experienceMonths;
  String? keySkill;
  String? industry;
  String? function;
  String? resume;

//upload resume
  String? file;

  Map<String, Object> educationalDetails = Map();

  void getFilePath() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      String filePath = result!.files.single.path!;
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      filePath = filePath.split('/').last.toString();
      setState(() {
        file = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  List<String> years = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25'
  ];
  List<String> months = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  List<String> chipList = [];
  TextEditingController textController = TextEditingController();

  String? skill;
  List<String> keySkills = [
    'F&B Service',
    'Management',
    'Cooking',
    'Housekeeping',
    'Accounts',
  ];

  List<String> preferedIndustryList = [
    "Food and Beverages",
    "Any Other",
    'tech',
  ];
  List<String> preferedFunctionList = [
    "Management",
    "Cooking",
    "F&B Service",
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
                : lastDate)
        .then((temp) {
      if (temp == null) return null;
      completer.complete(temp);
      setState(() {});
    });
    // else
    // DatePicker.showDatePicker(
    //   context,
    //   dateFormat: 'yyyy-mmm-dd',
    //   locale: DATETIME_PICKER_LOCALE_DEFAULT,
    //   onChange: (temp, selectedIndex) {
    //     if (temp == null) return null;
    //     completer.complete(temp);

    //     setState(() {});
    //   },
    // );
    return completer.future;
  }

  List<CardView> users = [];

  List<String> cityNames = [];
  String? city;

  List<String> citesList = [];
  getCitiesList() async {
   // EasyLoading.show(status: 'Please wait...');
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

  CandidateData? userData;

  getCandidateDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
     print("Professional creen id ${id}");
    CandidateDetailsService.getCandidateDetails(
        '${API.getCandidateDetails}/$id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null && value.data !=null) {
        setState(() {
          print("candidateDETailsuuuu");
          userData = value.data!;
          experienceYears=userData!.professionalInfo!.totalExperience.toString();
          experienceMonths=userData!.professionalInfo!.totalExperience.toString();
          keySkills=userData!.professionalInfo!.keySkills!;
          industry=userData!.professionalInfo!.preferredIndustry;
          function=userData!.professionalInfo!.preferredFunction;
          resume="resumee";
          print("Candidate Professional--Information Details:");
          print("Experience in years: ${value.data!.professionalInfo!.totalExperience}");
          print("Experience in moths: ${value.data!.professionalInfo!.totalExperience}");
          print("Keyskills: ${value.data!.professionalInfo!.keySkills}");
          print("Industry: ${value.data!.professionalInfo!.preferredIndustry}");
          print("Function: ${value.data!.professionalInfo!.preferredFunction}");
          print("Resume: ${"resumee"}");
        });



      }
    });
  }

  // skipScreen(BuildContext context, String candidateId) async {
  //   educationalDetails = await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => EducationalInfoScreen(
  //       jobDetails: users,
  //       candidateId: candidateId,
  //       educations: educationalDetails['educations'],
  //       highestQualification: educationalDetails['highestQualification'].toString(),
  //     ),
  //   ));
  // }

  // updateCandidate(BuildContext context, String candidateId) async {
  //   EasyLoading.show(status: 'Please wait ...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //
  //   String? _token = _prefs.getString('token');
  //
  //   CandidateUpdateServices.updateCandidate(
  //     API.candidateUpdate,
  //     candidateId,
  //     userData!.personalInfo!.name!,
  //     userData!.personalInfo!.mobile!,
  //     userData!.personalInfo!.email!,
  //     userData!.personalInfo!.address!,
  //     userData!.personalInfo!.state!,
  //     userData!.personalInfo!.city!,
  //     userData!.personalInfo!.pincode.toString(),
  //     userData!.personalInfo!.dob!,
  //     userData!.personalInfo!.maritalStatus!,
  //     userData!.personalInfo!.gender!,
  //     userData!.personalInfo!.aadhar!,
  //     _token!,
  //     scaffoldKey,
  //     //Professional info
  //     double.parse('$experienceYears.$experienceMonths'),
  //     chipList,
  //     industry!,
  //     function!,
  //     users,
  //     //education info page
  //     '',
  //     [],
  //     //job preference
  //     '',
  //     [],
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //   ).then((value) async {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       educationalDetails = await Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => EducationalInfoScreen(
  //           jobDetails: users,
  //           candidateId: candidateId,
  //           educations: educationalDetails['educations'],
  //           highestQualification: educationalDetails['highestQualification'].toString(),
  //         ),
  //       ));
  //     }
  //   });
  // }
}
