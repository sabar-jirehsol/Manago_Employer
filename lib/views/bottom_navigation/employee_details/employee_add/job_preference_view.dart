import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/previous_button.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/employee/job_preference_controller.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/city_constant.dart';

import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/Candidate_offer_letter.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/offer_letter.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/steps.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class JobPreferenceScreen extends StatefulWidget {
  static const String id = 'job_prefference_screen_id';
  // final List<CardView>? jobDetails;
  // final List<EducationCardView>? educationdetails;
  // final String? profileTitle;
  // final String? prefferedLocation;
  // final String? prefferedRole;
  // final String? prefferedJobType;
  // final String? shiftType;
  // final String? language;
  // final checkBoxValue;
  // final chipList;
  // final cityNames;
  String? candidateId;
  JobPreferenceScreen({
    // this.jobDetails,
    // this.educationdetails,
     this.candidateId,
    // this.profileTitle,
    // this.prefferedLocation,
    // this.prefferedRole,
    // this.prefferedJobType,
    // this.shiftType,
    // this.language,
    // this.chipList,
    // this.cityNames,
    // this.checkBoxValue,
  });

  @override
  _JobPreferenceScreenState createState() => _JobPreferenceScreenState();
}

class _JobPreferenceScreenState extends StateMVC<JobPreferenceScreen> {
  JobPreferenceController? _con;

  _JobPreferenceScreenState() : super(JobPreferenceController()) {
    _con = controller as JobPreferenceController?;
  }
  final _formKey = GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _con!.chipList = [];
    _con!.getCandidateDetails(widget.candidateId!);
    // _con!.jobdetails = widget.jobDetails!;
    // _con!.educationDetails = widget.educationdetails!;
    setState(() {_con!.getCandidateDetails(widget.candidateId!);});
    _con!.getCandidateDetails(widget.candidateId!).then((_) {
      setState(() {
        // _initialNameValue = _con!.userData?.personalInfo?.name ?? '';

      }); // Trigger a rebuild after fetching data
    });
  }
  Future<void> apiRefresh() async {
    // Call getCandidateDetails and await it
    await _con!.getCandidateDetails(widget.candidateId!);

    setState(() { });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.2),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                )),
          ),
        ),
        title: Text(
          'Job Preference',
          style: TextStyle(
              color: kSubtitleText, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CandidateOfferLetter(candidateId: widget.candidateId,)));
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Color(0xff3848F1),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],

      ),
      key: _con!.scaffoldKey,
      body:RefreshIndicator(
        onRefresh: apiRefresh,
        child: GestureDetector(
          onTap:()=> FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Steppers(activeStep: 3,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:[
                          BoxShadow(color: Colors.grey),
                          BoxShadow(
                            color: Colors.white70,
                            spreadRadius:0.0,
                            blurRadius: 20.0,
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("JobTitle  :"),
                        SizedBox(width: 10), // Spacer between icon and text
                        Text(
                          '${_con!.userData?.jobPreference?.profileTitle== null ?"click Here":_con!.userData?.jobPreference?.profileTitle}', // Text
                          style: TextStyle(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Text(_con!.userData?.jobPreference?.strength??"null"),
                  // ReusableTextField(
                  //   initialValue:_con!.userData?.jobPreference?.profileTitle,
                  //   readOnly: true,
                  //   hintText: "ProfileTile",
                  //   labelText: "ProfileTile",
                  //   onChanged: (value) {
                  //     //_con!.specialization = value;
                  //
                  //   },
                  //   keyboardType: TextInputType.text,
                  // ),
                  SizedBox(height: 20,),
                  ReusableTextField(
                    controller: TextEditingController(text:_con!.userData?.jobPreference?.strength ),
                    //initialValue:_con!.userData?.jobPreference?.strength,
                    readOnly: true,
                    hintText: "Strength",
                    labelText:"Strength",
                    onChanged: (value) {
                      //_con!.specialization = value;

                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  ReusableTextField(
                    controller: TextEditingController(text:_con!.userData?.jobPreference?.weakness),
                    //initialValue:_con!.userData?.jobPreference?.weakness,
                    readOnly: true,
                    hintText: "Weakness",
                    labelText:"Weakness",
                    onChanged: (value) {
                      //_con!.specialization = value;

                    },
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: 20,),
                  ReusableTextField(
                    controller: TextEditingController(text: _con!.userData?.jobPreference?.preferredLocation?[0].toString()),
                    //initialValue:_con!.userData?.jobPreference?.preferredLocation.toString(),
                    readOnly: true,
                    hintText: "Preferred Location",
                    labelText: "Preferred Location",
                    onChanged: (value) {
                      //_con!.specialization = value;

                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  ReusableTextField(
                    controller: TextEditingController(text: _con!.userData?.jobPreference?.preferredRole?[0].toString()),
                    //initialValue:_con!.userData?.jobPreference?.preferredLocation.toString(),
                    readOnly: true,
                    hintText: "Preferred Role",
                    labelText: "Preferred Role",
                    onChanged: (value) {
                      //_con!.specialization = value;

                    },
                    keyboardType: TextInputType.text,
                  ),
                  // ReusableDropDown(
                  //   // validate: (month) {
                  //   //   if (month == null) {
                  //   //     return 'Experience Month is required';
                  //   //   }
                  //   // },
                  //   hintText:_con!.userData?.jobPreference?.preferredRole?[0].toString(),// 'Preferred Role',
                  //   options:["cricket player","speaker","chef"],
                  //   value:_con!.userData?.jobPreference?.preferredRole?[0].toString(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       //_con!.skill = value;
                  //     });
                  //   },
                  // ),

                  SizedBox(height: 20,),
                  ReusableTextField(
                    controller: TextEditingController(text: _con!.userData?.jobPreference?.language?[0].toString()),
                    //initialValue:_con!.userData?.jobPreference?.preferredLocation.toString(),
                    readOnly: true,
                    hintText: "Language",
                    labelText: "Language",
                    onChanged: (value) {
                      //_con!.specialization = value;

                    },
                    keyboardType: TextInputType.text,
                  ),
                  // ReusableDropDown(
                  //   // validate: (month) {
                  //   //   if (month == null) {
                  //   //     return 'Experience Month is required';
                  //   //   }
                  //   // },
                  //   hintText:_con!.userData?.jobPreference?.language?[0].toString(),// 'Language',
                  //   options:["Tamil","English"],
                  //   value:_con!.userData?.jobPreference?.language?[0].toString(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       //_con!.skill = value;
                  //     });
                  //   },
                  // ),

              SizedBox(height: 50,),
                  Align(
                      alignment: Alignment.center,
                      child: ReusableButton(
                          title: 'Continue',
                          onPressed: () {





                            //_con!.saveCandidate(context);
                            // _con!.saveCandidateviamobile(context);

                          Navigator.push(context,MaterialPageRoute(builder: (context)=>CandidateOfferLetter(candidateId: widget.candidateId,)));

                          }))

                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
