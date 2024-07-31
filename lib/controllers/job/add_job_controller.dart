import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:manago_employer/services/JobSaveService.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/job/jobs.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/success_dialogbox.dart';

class AddJobController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // String? newState;
  // String? city;
  //String? pincode;
  String? jobTitle;
  String? designation;
  int? minexperience;
  int? maxexperience;
  List<String>skills=[];
  //String? skillList;
  String? jobCountry;
  String? jobState;
  String? jobcity;
  String? salary;
  String? vaccancyOpening;
  String? description;
  //String? skill;


  List<String> countries = [];
  List<String> newStates = [];
  List<String> cities = [];



  bool jobTitleError       = false;
  bool designationError    = false;
  bool  minexperienceError    = false;
  bool  maxexperienceError    = false;
  bool skillError           =false;
  bool  jobCountryError       =false;
  bool  jobStateError       =false;
  bool  jobcityError        =false;
  bool  salaryError          =false;
  bool vaccancyOpeningError  =false;
  bool   descriptionError    =false;


  String? jobTitleError_text;
  String? designationError_text;
  String? minexpError_text;
  String? maxexpError_text;
  String? skillError_text;
  String? jobCountryError_text;
  String? jobstateError_text;
  String? jobcityError_text;
  String? salaryError_text;
  String?  vaccancyOpeningError_text;
  String?  descError_text;


  TextEditingController addjobCountryController = TextEditingController();


  //  List<String> citesList = [];
  // getCitiesList() async {
  //   //EasyLoading.show(status: 'Please wait...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getCitiesList(API.getCityStateMap, _token!, scaffoldKey)
  //       .then((value) {
  //     //EasyLoading.dismiss();
  //     if (value != null) {
  //       citesList = value;
  //       setState(() {});
  //     }
  //   });
  // }

  List<String> searchCountryList = [];

  getSearchCountryList(String value) async {
    EasyLoading.show(status: 'Please wait...', dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String? _token = _prefs.getString('token');
    FilterDataServices.getSearchCountryList(
        API.preferredCountry, value, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        searchCountryList = value;
        print("Search Country Places");
        print(searchCountryList);
        setState(() {

        });
      }
    });
    EasyLoading.dismiss();
  }

  addJob(BuildContext context) async {
    if (jobTitle == null || jobTitle!.isEmpty) {
      jobTitleError=true;
      jobTitleError_text="Job Title is Required. ";
      //Alert.showSnackbar('Job Title should not be null', context);
    }  if (designation == null || designation!.isEmpty) {
      designationError=true;
      designationError_text="Designation is Required.";

      //Alert.showSnackbar('Designation should not be empty.', context);
    }  if (minexperience == null) {
      minexperienceError=true;
      minexpError_text="Min Experience is Required.";
      //Alert.showSnackbar('Experience should not be empty', context);
    }
    //  else if (skills.length == 0) {
    //   Alert.showSnackbar('Key Skills should not be empty', context);
    // }
    if (maxexperience == null) {
      maxexperienceError=true;
      maxexpError_text="Max Experience is Required.";
      //Alert.showSnackbar('Experience should not be empty', context);
    }



     if (skills == null || skills.isEmpty) {
        skillError=true;
        skillError_text="Select Key skills";
     // Alert.showSnackbar('Key Skills should not be empty', context);
    }if (jobState == null) {
      jobCountryError=true;
      jobCountryError_text="Country  is Required.";
      //return Alert.showSnackbar('State should not be empty.', context);
    }


     if (jobState == null) {
       jobStateError=true;
       jobstateError_text="State is Required.";
      //return Alert.showSnackbar('State should not be empty.', context);
    }  if (jobcity == null) {
       jobcityError=true;
       jobcityError_text="City is Required.";
      //return Alert.showSnackbar('City should not be empty.', context);
    }

    if (salary == null || salary!.isEmpty||salary!.length < 4) {
      salaryError=true;
      salaryError_text="Salary is Required and  can't be  less than 4 digit.";
      //Alert.showSnackbar('Salary should not be empty', context);
    }
    if (vaccancyOpening == null || vaccancyOpening!.isEmpty||vaccancyOpening == "0") {
      vaccancyOpeningError=true;
      vaccancyOpeningError_text="Vaccancy should not be empty and can't be 0.";
      //Alert.showSnackbar('Vaccancy should not be empty', context);
    }   if (description == null || description!.isEmpty) {
      descriptionError=true;
      descError_text="Job Description is Required";
      //Alert.showSnackbar('Description should not be empty', context);
    }
    if (minexperience! >maxexperience!) {
      minexperienceError=true;
      minexpError_text="MinExperience must be less than MaxExperience";
      //Alert.showSnackbar('Experience should not be empty', context);
    }
    if (maxexperience! <minexperience!) {
      maxexperienceError=true;
      maxexpError_text="MaxExperience must be more than MinExperience";
      //Alert.showSnackbar('Experience should not be empty', context);
    }
    if(jobTitleError==false &&
    designationError==false &&
    minexperienceError==false && minexperienceError==false &&
    skillError==false &&
        jobCountryError==false &&
    jobStateError==false &&
    jobcityError==false &&
    salaryError==false &&
    vaccancyOpeningError==false &&
    descriptionError ==false  )
    {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      String? _id = _prefs.getString('employerId');
      print("runtime type");
      print(minexperience.runtimeType);
      print(maxexperience.runtimeType);
      JobSaveServices.addJob(
              API.jobSave,
              jobTitle!,
              designation!,
              minexperience!,
              maxexperience!,
              skills,
              jobCountry!,
              jobState!,
               jobcity!,
              salary!,
              vaccancyOpening!,
              description!,
              _id!,
              scaffoldKey,context)
          .then((value) {
        //EasyLoading.dismiss();
        if (value != null) {
          //EasyLoading.showSuccess("Job Posted Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Jobs(),
          //     ));
          //Alert.showSnackbar('jobs Posted', context);
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
                        imagePath: 'assets/images/tick.png',
                        message:'Job Posted Successfully' ,
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

  List<String> designationList = [];
  getDesignationList() async {
   // EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getDesignations(API.getDesignation,  scaffoldKey)
        .then((value) {
     // EasyLoading.dismiss();
      if (value != null) {
        designationList = value;
        setState(() {});
      }
    });
  }

  List<String> skillSetList = [];
  getSkillsList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getSkills, scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        skillSetList = value;
        setState(() {});
      }
    });
  }

  // List<String> experienceList = [
  //   "1 - 4",
  //   "5- 10",
  //   "10 – 15",
  //   "15- 20",
  //   "20-25",
  // ];
  List<String> Min_MaxexperienceList=[
    "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"
    "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"
  ];

  List<String> experienceList=[];
  getExperinceList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getExperience(API.getExperience, scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        experienceList = value;
        setState(() {});
      }
    });
  }

  loadCountries(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap:false);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getCountriesList(API.getCountryList,  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        countries = value.data;
        setState(() {});
      }
    });
  }

  loadjobStates(String country) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getCompanyStatesList(API.getCountryStateList,country, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        newStates = value.data;
        setState(() {});
      }
    });
  }

  loadjobStateCities( String country,String state) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices. getCompanyStatesCityList(
        API.getCountryStatecityList, country,state, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        cities = value.data;
        setState(() {});
      }
    });
  }
  // loadStates(BuildContext context) async {
  //   //EasyLoading.show(status: 'Please wait...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('employerId');
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getStatesList(API.getCityStateMap,  scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       newStates = value;
  //       setState(() {});
  //     }
  //   });
  // }
  //
  //
  // loadCities(String state) async {
  //   //EasyLoading.show(status: 'Please wait...');
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('employerId');
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getCitiesOfaStateList(
  //       API.getCityStateMap, state, scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       cities = value;
  //       setState(() {});
  //     }
  //   });
  // }





  TextEditingController textController = TextEditingController();

  // List<India> tempStates = List<India>();
  // List<String> newStates = List<String>();
  // List<String> cities = List<String>();

  // loadStates(BuildContext context) async {
  //   String data = await rootBundle.loadString('assets/location/states.json');
  //   final jsonResult = stateModelFromJson(data);
  //   tempStates = jsonResult.india;
  //   jsonResult.india.forEach((element) {
  //     newStates.add(element.state);
  //     setState(() {});
  //   });
  // }

  // loadCities(String state) {
  //   city = null;
  //   for (India item in tempStates) {
  //     // ignore: unrelated_type_equality_checks
  //     if (item.state == state) {
  //       cities = item.cities;
  //     }
  //   }
  // }

  // selectDate(BuildContext context, DateTime initialDateTime,
  //     {DateTime lastDate}) async {
  //   Completer completer = Completer();
  //   if (Platform.isAndroid)
  //     showDatePicker(
  //             context: context,
  //             initialDate: initialDateTime,
  //             firstDate: DateTime(1970),
  //             lastDate: lastDate == null
  //                 ? DateTime(initialDateTime.year + 10)
  //                 : lastDate)
  //         .then((temp) {
  //       if (temp == null) return null;
  //       completer.complete(temp);
  //       setState(() {});
  //     });
  //   else
  //     DatePicker.showDatePicker(
  //       context,
  //       dateFormat: 'yyyy-mmm-dd',
  //       locale: 'en',
  //       onConfirm2: (temp, selectedIndex) {
  //         if (temp == null) return null;
  //         completer.complete(temp);

  //         setState(() {});
  //       },
  //     );
  //   return completer.future;
  // }
}
