import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/services/JobDetailsService.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/services/UpdateJobServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail_controller_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/success_dialogbox.dart';

class UpdateJobController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? designation;
  String? jobTitle;
  // String? experience;
  int? experience;
  int? minexperience;
  int? maxexperience;
  List<String> skills =[];
   String? salary;
   String? vaccancyOpening;

  // int? salary;
  //int? vaccancyOpening;
  String?jobCountry;
  String? jobState;
  String? jobcity;
  List<String> countries = [];
  List<String> newStates = [];
  List<String> cities = [];
  String? description;
  List<String> designationList = [];

  TextEditingController updatejobCountryController = TextEditingController();

  bool jobTitleError=false,   jobStateError=false,jobCountryError=false,
    jobcityError=false,designationError=false,minexpError=false,maxexpError=false,
      skillError=false,salaryError=false,vaccancyOpeningError=false,descError=false;

  List<String> Min_MaxexperienceList=[
    "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"
        "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"
  ];


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
  getDesignationList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getDesignations(API.getDesignation,scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        designationList = value;
        setState(() {});
      }
    });
  }

  List<String> keySkills = [];
  getSkillsList() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getSkills, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        keySkills = value;
        setState(() {});
      }
    });
  }

  List<String> experienceList = [ ];
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

  TextEditingController textController = TextEditingController();

  updateJob(String id, BuildContext context) async {
    if (jobTitle == null || jobTitle!.isEmpty) {
       jobTitleError=true;
     // Alert.showSnackbar('Job Title should not be null', context);
    }  if (designation == null || designation!.isEmpty) {
      designationError=true;
      //Alert.showSnackbar('Designation should not be empty.', context);
    }  if (minexperience! > maxexperience!) {
      minexpError=true;
      //Alert.showSnackbar('Experince should not be empty', context);
    }   if (maxexperience! < minexperience!) {
      maxexpError=true;
      //Alert.showSnackbar('Experince should not be empty', context);
    }


    if (skills.length==null) {
      skillError=true;
      //Alert.showSnackbar('Key Skills should not be empty', context);
    }if (jobState == null) {
      jobCountryError=true;

      //return Alert.showSnackbar('State should not be empty.', context);
    }

    if (jobState == null) {
      jobStateError=true;

      //return Alert.showSnackbar('State should not be empty.', context);
    }  if (jobcity == null) {
      jobcityError=true;

      //return Alert.showSnackbar('City should not be empty.', context);
    }
    if (salary == null || salary!.isEmpty||salary!.length < 4) {
      salaryError=true;

      //Alert.showSnackbar('Salary should not be empty', context);
    } if (vaccancyOpening == null||vaccancyOpening!.isEmpty) {
      vaccancyOpeningError=true;
      //Alert.showSnackbar('Vaccancy should not be empty', context);
    }  if (description == null || description!.isEmpty) {
      descError=true;
      //Alert.showSnackbar('Description should not be empty', context);
    } if(
    jobTitleError==false && designationError==false && minexpError==false&&maxexpError==false
        && skillError==false &&  jobCountryError==false &&
        jobStateError==false&&jobcityError==false&& salaryError==false &&  vaccancyOpeningError==false && descError==false
    ) {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');

      print("send for updating");
      print("Id ${id.runtimeType} and value is ${id}");
      print("jobTitle ${jobTitle.runtimeType} and value is ${jobTitle}");
      print("designation ${designation.runtimeType} and value is ${designation}");
      print("experi ${minexperience.runtimeType} and value is ${minexperience}");
      print("skills ${skills.runtimeType} and value is ${skills}");
      print("salary ${salary.runtimeType} and value is ${salary}");
      print("vac ${vaccancyOpening.runtimeType} and value is ${vaccancyOpening}");
      print("desc ${description.runtimeType} and value is ${description}");
      UpdateJobService.updateJob(
              API.updateJob,
              id,
              designation!,
              jobTitle!,
              minexperience!,
              maxexperience!,
              skills,
              jobCountry!,
              jobState!,
              jobcity!,
              salary!,
              vaccancyOpening!,
              description!,
             scaffoldKey,
              context
              // skills,
              // experience!,
              // jobTitle!,
              // salary!,
              // vaccancyOpening!,
              // description!,
              // scaffoldKey)
          )
          .then((value) {
        //EasyLoading.dismiss();
        if (value != null) {
         //  EasyLoading.showSuccess("Job Updated Successfully",dismissOnTap: true,duration: Duration(seconds: 2));
         // // Alert.showSnackbar('job Updated', context);
         //  Future.delayed(Duration(milliseconds: 900),(){
         //
         //    Navigator.pop(context);
         //  });
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
                        imagePath: 'assets/images/doc_edit.png',
                        message:'Job Updated Successfully' ,
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

  JobDetailsModel? jobDetails;

  void getJobDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    JobDetailsService.jobDetailsService(
            '${API.jobDetails}/$id',scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        setState(() {
          // jobDetails = value;
          // skills = jobDetails!.data!.keyskills!;
          // designation = jobDetails!.data!.designation!;
          // jobTitle = jobDetails!.data!.jobTitle!;
          // experience = jobDetails!.data!.experience!;
          // salary = jobDetails!.data!.salary!;
          // vaccancyOpening = jobDetails!.data!.vaccancy!;
          // description = jobDetails!.data!.description!;
          jobDetails = value;
          print('jobDetails = $jobDetails');
          print(jobDetails.runtimeType);
          print("job id ${jobDetails!.data!.id}");
          skills = jobDetails!.data!.keyskills!;
          print('skills = $skills');


          designation = jobDetails!.data!.designation!;
          print('designation = $designation');


          jobTitle = jobDetails!.data!.jobTitle!;
          print('jobTitle = $jobTitle');

          experience =jobDetails!.data!.experience!;
          print('experience = $experience');
          minexperience =jobDetails!.data!.minexperience!;
          print('minexperience = $minexperience');

          maxexperience =jobDetails!.data!.maxexperience!;
          print('minexperience = $minexperience');


          jobCountry=jobDetails!.data!.country?[0];
          updatejobCountryController.text=jobDetails!.data!.country?[0]??"";
          jobState= jobDetails!.data!.state?[0];
          jobcity=jobDetails!.data!.city?[0];
          salary = jobDetails?.data?.salary.toString();
          print('salary = $salary and ');


          vaccancyOpening = jobDetails?.data?.vaccancy.toString();
          print('vaccancyOpening = $vaccancyOpening');



          description = jobDetails!.data!.description!;
          print('description = $description');




        });
      }
    });
  }
}
