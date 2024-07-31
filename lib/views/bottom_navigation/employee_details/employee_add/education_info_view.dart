import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/previous_button.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_card_container.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/controllers/employee/education_info.dart';
import 'package:manago_employer/models/education.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/job_preference_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/professional_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/steps.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../components/reusable_textField.dart';
import '../../../../components/searchable_dropDown.dart';

class EducationalInfoScreen extends StatefulWidget {
  static const String id = 'educational_info_screen_id';
  //List<CardView>? jobDetails;
  final String? candidateId;
  //final String? highestQualification;
  //final educations;

  EducationalInfoScreen(
      {Key? key,
     // this.jobDetails,
      this.candidateId,
      //this.highestQualification,
     // this.educations
   })
      : super(key: key);
  @override
  _EducationalInfoScreenState createState() => _EducationalInfoScreenState();
}

class _EducationalInfoScreenState extends StateMVC<EducationalInfoScreen> {
  EducationalInfoController? _con;

  _EducationalInfoScreenState() : super(EducationalInfoController()) {
    _con = controller as EducationalInfoController?;
  }
 var _education = Education();
  final _formkey = GlobalKey<FormState>();


  List<Map<String, String>> educationDetailsList = [];



  @override
  void initState() {
    super.initState();
    apiRefresh();
    _con!.getCandidateDetails(widget.candidateId!);

    //_con!.jobDetails = widget.jobDetails!;
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
          'Education',
          style: TextStyle(
              color: kSubtitleText, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfessionalInfoScreen(candidateId:widget.candidateId!,)));
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
      body: RefreshIndicator(
        onRefresh: apiRefresh,
        child: GestureDetector(
          onTap:()=> FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Steppers(activeStep: 1,),
                  // Container(
                  //   padding:
                  //   const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  //   width: MediaQuery.of(context).size.width / 4,
                  //   child:Steppers(activeStep: 1,),
                  //
                  // ),



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
                       Text("Highest Qualification :"),
                        SizedBox(width: 10), // Spacer between icon and text
                        Text(
                          '${_con!.userData?.educationalInfo?.highestQualification== null ?"click Here":_con!.userData?.educationalInfo?.highestQualification}', // Text
                          style: TextStyle(fontSize: 16,color:kBlueGrey,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),



                  SizedBox(height: 50,),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _con!.userData?.educationalInfo?.educationDetails?.length ?? 0,
                    itemBuilder: (context, index) {
                     var educationDetail = _con!.userData!.educationalInfo!.educationDetails![index];
                      // Map<String, String> educationDetails = {
                      //   'educationType': educationDetail.educationType ?? '',
                      //   'specialization':educationDetail.specialization?? '',
                      //   'university': educationDetail.university ?? '',
                      //   'startDate':educationDetail.startDate ?? '',
                      //   'endDate': educationDetail.endDate ?? '',
                      //   'awardsAndAchivement':educationDetail.awardsAndAchivement ?? '',
                      //
                      // };
                      // // Check if the educationDetails already exist in the list
                      // bool alreadyExists = educationDetailsList.contains(educationDetails);
                      //
                      // // Add to educationDetailsList only if it's not already there
                      // if (!alreadyExists) {
                      //   educationDetailsList.add(educationDetails);
                      // }
                      // print(
                      //     'Added education details to list: $educationDetailsList');
                      // educationDetailsList.add(educationDetails);

                      return Container(
                        //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableTextField(

                              initialValue:educationDetail.educationType,

                              keyboardType:TextInputType.visiblePassword,
                              hintText: "Education Type",
                              labelText: "Education Type",
                              onChanged: (value) {
                                _con!.educationType = value;
                                print("education Type${educationDetail.educationType}");


                              },
                              //keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 10),

                            ReusableTextField(
                              initialValue:educationDetail.specialization,
                              keyboardType:TextInputType.visiblePassword,
                              hintText: "Specialization",
                              labelText: "Specialization",
                              onChanged: (value) {
                                _con!.specialization = value;
                                print("education Type${educationDetail.specialization}");
                              },
                              //keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 10),
                            ReusableTextField(
                              initialValue:educationDetail.university,
                              keyboardType:TextInputType.visiblePassword,
                              hintText: "School or University",
                              labelText: "School or University",
                              onChanged: (value) {
                                _con!.school = value;
                                print("education Type${educationDetail.university}");
                              },
                             // keyboardType: TextInputType.text,
                            ),

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: kGreyColor)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.white,
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            educationDetail.startDate == null
                                                ? 'StartDate'
                                                : '${educationDetail.startDate}',
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black54),
                                          ),
                                          Icon(Icons.calendar_month_outlined)
                                        ],
                                      ),
                                    ),
                                    onPressed: () async {
                                      DateTime startDate =
                                      await _con!.selectDate(context, DateTime.now());
                                      final df = new DateFormat('dd-MMM-yyyy');
                                      _con!.startDate = df.format(startDate);
                                      setState(() {});
                                    },
                                  ),
                                ),


                                SizedBox(width: 6,),
                                Expanded(
                                  child: MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: kGreyColor)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.white,
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            educationDetail.endDate == null
                                                ? 'EndDate'
                                                : '${educationDetail.endDate}',
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black54),
                                          ),
                                          Icon(Icons.calendar_month_outlined)
                                        ],
                                      ),
                                    ),
                                    onPressed: () async {
                                      DateTime endDate =
                                      await _con!.selectDate(context, DateTime.now());
                                      final df = new DateFormat('dd-MMM-yyyy');
                                       _con!.endDate = df.format(endDate);
                                      setState(() {});
                                    },
                                  ),
                                ),

                              ],

                            ),
                            SizedBox(height: 10),

                            ReusableTextField(
                              initialValue:educationDetail.awardsAndAchivement ?? 'Empty',
                              keyboardType:TextInputType.visiblePassword,
                              hintText: "Awards and Achievements",
                              labelText: "Awards and Achievements",
                              onChanged: (value) {
                                _con!.awards = value;
                                print("education Type${educationDetail.university}");
                              },
                             // keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 50,)


                          ],
                        ),
                      );
                    },

                  ),
                // Add values to the list outside of ListView.builder




            SizedBox(
                    height: 20,
                  ),

//todo i commented below(manual section) at 11.4.24 19:13
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: _con!.educations.length == 0
                              ? 'Add Education Info'
                              : 'Add More +',
                          style: TextStyle(color:kBlueGrey, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.only(right:8.0,left: 8.0),
                                  child: AlertDialog(
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.white,
                                    title: Text('Education Info Card'),
                                    content: EducationCardView(

                                      education: _education,
                                    ),
                                    actions: [
                                      MaterialButton(
                                          onPressed: () {

                                            Navigator.of(context).pop();
                                            _education = Education();
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 12,color: kBlueGrey),
                                          )),
                                      MaterialButton(
                                          onPressed: () {
                                            _con!.educations.add(EducationCardView(
                                              education: _education,
                                            ));
                                            // onAddForm();
                                            Navigator.of(context).pop();
                                            _education = Education();
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(fontSize: 12,color: kBlueGrey),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            })
                    ]),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 30),



                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _con!.educations.length,
                    itemBuilder: (context, index) {
                      var savededu = _con!.educations[index].education!;
                      // Map<String, String> educationDetails = {
                      //   'educationType': savededu.educationType ?? '',
                      //   'specialization':savededu.specialization?? '',
                      //   'university': savededu.university ?? '',
                      //   'startDate': savededu.startDate ?? '',
                      //   'endDate': savededu.endDate ?? '',
                      //   'awardsAndAchivement':savededu.awards ?? '',
                      //
                      // };
                      // print(
                      //     'Added education details to list: $educationDetailsList');
                      //educationDetailsList.add(educationDetails);
                      return Container(
                        //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableTextField(

                              initialValue:savededu.educationType,
                              hintText: "Education Type",
                              labelText: "Education Type",
                              onChanged: (value) {
                               // _con!.educationType = value;



                              },
                              keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 10),

                            ReusableTextField(
                              initialValue:savededu.specialization,

                              hintText: "Specialization",
                              labelText: "Specialization",
                              onChanged: (value) {
                                _con!.specialization = value;

                              },
                              keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 10),
                            ReusableTextField(
                              initialValue:savededu.university,

                              hintText: "School or University",
                              labelText: "School or University",
                              onChanged: (value) {
                                _con!.school = value;
                                print("saveedu.university${_con!.school}");
                                print("_con!.school${_con!.school}");

                              },
                              keyboardType: TextInputType.text,
                            ),

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: kGreyColor)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.white,
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            savededu.startDate == null
                                                ? 'StartDate'
                                                : '${savededu.startDate}',
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black54),
                                          ),
                                          Icon(Icons.calendar_month_outlined)
                                        ],
                                      ),
                                    ),
                                    onPressed: () async {
                                      DateTime startDate =
                                      await _con!.selectDate(context, DateTime.now());
                                      final df = new DateFormat('dd-MMM-yyyy');
                                      _con!.startDate=savededu.startDate;
                                       //_con!.startDate = df.format(startDate);
                                       print("startDate ${_con!.startDate}");
                                      setState(() {});

                                    },
                                  ),
                                ),


                                SizedBox(width: 6,),
                                Expanded(
                                  child: MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: kGreyColor)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.white,
                                    child: Container(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            savededu.endDate == null
                                                ? 'EndDate'
                                                : '${savededu.endDate}',
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.black54),
                                          ),
                                          Icon(Icons.calendar_month_outlined)
                                        ],
                                      ),
                                    ),
                                    onPressed: () async {
                                      DateTime endDate =
                                      await _con!.selectDate(context, DateTime.now());
                                      final df = new DateFormat('dd-MMM-yyyy');
                                      _con!.endDate=savededu.endDate;
                                      // _con!.endDate = df.format(endDate);
                                      setState(() {});
                                    },
                                  ),
                                ),

                              ],

                            ),
                            SizedBox(height: 10),

                            ReusableTextField(
                              initialValue:savededu.awards ?? 'Empty',
                              hintText: "Awards and Achievements",
                              labelText: "Awards and Achievements",
                              onChanged: (value) {
                                _con!.awards = value;
                                print("awrds${_con!.awards}");
                              },
                              keyboardType: TextInputType.text,
                            ),


                            SizedBox(height: 50,),













                          ],
                        ),
                      );
                    },
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: ReusableButton(
                          title: 'Continue',
                          onPressed: () {
                            // Map<String, String> educationDetails = {
                            //   'educationType': _con!.educationType ?? '',
                            //   'specialization': _con!.specialization ?? '',
                            //   'university': _con!.school ?? '',
                            //   'startDate': _con!.startDate ?? '',
                            //   'endDate': _con!.endDate ?? '',
                            //   'awardsAndAchivement': _con!.awards ?? '',
                            //
                            // };
                            // print(
                            //     'Added education details to list: $educationDetailsList');
                            // educationDetailsList.add(educationDetails);




                            //_con!.saveCandidate(context);
                            // _con!.saveCandidateviamobile(context);
                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfessionalInfoScreen(candidateId:widget.candidateId!,)));


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
