import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:manago_employer/services/CandidateSaveServices.dart';
import 'package:manago_employer/services/CandidateViaMobile.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/professional_info_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/AddEmployeeModel.dart';
import '../../models/AddExperienceLetterModal.dart';
import '../../models/CandidateDetailsModel.dart';
import '../../services/CandidateDetailsServices.dart';
import '../../utils/alert.dart';
import '../../views/bottom_navigation/employee_details/employee_add/education_info_view.dart';

class PersonalInfoController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? email;
  String? address;
  String? newState;
  String? city;
  String? pincode;
  String? dob;
  String? maritialStatus;
  String? gender;
  String? aadhar;
  String? mobile;
  bool  saveCandidateViaMobile=false;
  Map<String, Object> professionalDetails = Map();


// // Function to populate professionalDetails
//   void populateProfessionalDetails() {
//     // Add sample data to professionalDetails
//     professionalDetails = {
//       "experienceYears": "5",
//       "experienceMonths": "6",
//       "keySkill": ["Skill 1", "Skill 2"],
//       "industry": "IT",
//       "function": "Software Development",
//       "resume": "Resume URL",
//       "chipList": ["Chip 1", "Chip 2"],
//     };
//   }




  List<India> tempStates = [];
  List<String> newStates = [];
  List<String> cities = [];

  loadStates(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getStatesList(API.getCityStateMap,  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        newStates = value;
        setState(() {});
      }
    });
  }

  loadCities(String state) async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    //String? _token = _prefs.getString('token');
    FilterDataServices.getCitiesOfaStateList(API.getCityStateMap,state, scaffoldKey).then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        cities = value;
        setState(() {});
      }
    });
  }

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
    ).then((temp) {
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

  String? candidateId;
  String? candidateUSERId;

  saveCandidate(BuildContext context) async {
    //EasyLoading.show(status: 'Please wait ...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _id = _prefs.getString('id');
      //String? _token = _prefs.getString('token');
      CandidateSaveServices.saveCandidate(
        //personal Info
          API.candidateSave,
          name!,
          mobile!,
          email!,
          address!,
          newState!,
          city!,
          pincode!,
          dob!,
          maritialStatus!,
          gender!,
          aadhar,
          //_token!,
          scaffoldKey,
          //ProfessionalInfo
          0,
          [],
          '',
          '',
          [],
          //Education info
          '',
          [],
          //Job preference
          '',
          [],
          '',
          '',
          '',
          '',
          '',
          _id!)
          .then((value) async {
        //EasyLoading.dismiss();
        if (value != null) {

          candidateId = value.data!.id;
          print("candidateId ${candidateId}");

          print("Professional Details ${professionalDetails["experienceYears"]}");
         // professionalDetails = await Navigator.push(
              // context,
              // MaterialPageRoute(
              //   builder: (context) =>
              //       ProfessionalInfoScreen(
              //         candidateId:candidateId!,
              //         experienceYears: professionalDetails["experienceYears"]
              //             .toString(),
              //         experienceMonths: professionalDetails["experienceMonths"]
              //             .toString(),
              //         keySkill: professionalDetails["keySkill"].toString(),
              //         industry: professionalDetails["industry"].toString(),
              //         function: professionalDetails["function"].toString(),
              //         resume: professionalDetails["resume"].toString(),
              //         chipList: professionalDetails["chipList"],
              //       ),
              // ));
          Navigator.push(context,MaterialPageRoute(builder: (context)=>EducationalInfoScreen(candidateId:candidateId)));

        }
      });
    }









  saveCandidateviamobile(mobile,BuildContext context) async {
    //EasyLoading.show(status: 'Please wait ...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('id');
    //String? _token = _prefs.getString('token');
    CandidateSaveServicesviamoible.saveCandidateviaMobile(
      //personal Info
        API.candidateSave,
        mobile, //"7808388162",
      scaffoldKey,
       )
        .then((value) async {
      //EasyLoading.dismiss();
      if (value != null) {

        candidateId = value.data!.id;
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        print("candidateId ${value.data?.id}");
        candidateUSERId = value.data!.userId;
        print("candidateUSERID ${candidateUSERId}");
        getCandidateDetails(candidateId);
        saveCandidateViaMobile=true;
        // professionalDetails = await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           ProfessionalInfoScreen(
        //             candidateId:candidateId!,
        //             experienceYears: professionalDetails["experienceYears"]
        //                 .toString(),
        //             experienceMonths: professionalDetails["experienceMonths"]
        //                 .toString(),
        //             keySkill: professionalDetails["keySkill"].toString(),
        //             industry: professionalDetails["industry"].toString(),
        //             function: professionalDetails["function"].toString(),
        //             resume: professionalDetails["resume"].toString(),
        //             chipList: professionalDetails["chipList"],
        //           ),
        //     ));
        //Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfessionalInfoScreen()));
      }
    });
  }










  CandidateData? userData;

  getCandidateDetails(candidateId) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    CandidateDetailsService.getCandidateDetails(
        '${API.getCandidateDetails}/$candidateId', scaffoldKey)
        .then((value) {
     // EasyLoading.dismiss();
      if (value != null && value.data != null) {
        setState(() {
          userData=value.data!;
          name=value.data!.personalInfo!.name;
          email=value.data!.personalInfo!.email;
          gender=value.data!.personalInfo!.gender;
          dob=value.data!.personalInfo!.dob;
          address=value.data!.personalInfo!.address;
          newState=value.data!.personalInfo!.state;
          city=value.data!.personalInfo!.city;
          pincode=value.data!.personalInfo!.pincode.toString();
          maritialStatus=value.data!.personalInfo!.maritalStatus;
          aadhar=value.data?.personalInfo?.aadhar;
        });



        print("Candidate Personal--Information Details:");
        print("Name: ${value.data!.personalInfo?.name}");
        print("Mobile: ${value.data!.personalInfo?.mobile}");
        print("Email: ${value.data!.personalInfo?.email}");
        print("Gender: ${value.data!.personalInfo?.gender}");
        print("DOB: ${value.data!.personalInfo?.dob}");
        print("Address: ${value.data!.personalInfo?.address}");
        print("State: ${value.data!.personalInfo?.state}");
        print("City: ${value.data!.personalInfo?.city}");
       // print("Country: ${value.data!.personalInfo?.country}");
        print("Pin Code: ${value.data!.personalInfo?.pincode}");
        print("Marital Status: ${value.data!.personalInfo?.maritalStatus}");
        print("Aadhar: ${value.data!.personalInfo?.aadhar}");
       // print("Introduction: ${value.data!.personalInfo?.introduction}");

        // You can similarly print other details like professionalInfo, jobPreference, educationalInfo, etc.
      } else {
        print("Candidate details not found or null");
      }
    });
  }







  }

