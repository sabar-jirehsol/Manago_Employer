import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/previous_button.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_card_container.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/employee/professional_info_controller.dart';
import 'package:manago_employer/models/user.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/job_preference_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/steps.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../models/ApplicantDetailModel.dart';

class ProfessionalInfoScreen extends StatefulWidget {
  static const String id = 'professional_screen_id';
  final String? candidateId;

  const ProfessionalInfoScreen({
    Key? key,
    this.candidateId,
  }) : super(key: key);

  @override
  _ProfessionalInfoScreenState createState() =>
      _ProfessionalInfoScreenState();
}

class _ProfessionalInfoScreenState
    extends StateMVC<ProfessionalInfoScreen> {
  ProfessionalInfoController? _con;
  _ProfessionalInfoScreenState()
      : super(ProfessionalInfoController()) {
    _con = controller as ProfessionalInfoController;
  }
  final _formkey = GlobalKey<FormState>();
  var _user = User();

  @override
  void initState() {
    super.initState();
    _con!.chipList = [];

    _con!.getCandidateDetails(widget.candidateId!);

    print("Exxxxxxxxxxxxxx");
    setState(() {
      _con!.userData?.professionalInfo!.totalExperience.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              ),
            ),
          ),
        ),
        title: Text(
          'Professional Information',
          style: TextStyle(
            color: kSubtitleText,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>JobPreferenceScreen(candidateId:widget.candidateId!,)));
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Steppers(activeStep: 2,),


                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     // color: Colors.grey.withOpacity(0.1),
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow:[
                //         BoxShadow(color: Colors.grey),
                //         BoxShadow(
                //           color: Colors.white70,
                //           spreadRadius:0.0,
                //           blurRadius: 20.0,
                //         )
                //       ]
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Total year of Experience(in Months) :"),
                //       SizedBox(width: 10), // Spacer between icon and text
                //       Text(
                //         '${_con!.userData?.educationalInfo?.highestQualification== null ?" ":_con!.userData?.professionalInfo?.totalExperience}', // Text
                //         style: TextStyle(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
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
                      Text("Total Year of Experience(in Months):"),
                      SizedBox(width: 10), // Spacer between icon and text
                      Text(
                        '${_con!.userData?.professionalInfo?.totalExperience.toString()== null ?"click Here":_con!.userData?.professionalInfo?.totalExperience?.toInt().toString()}', // Text
                        style: TextStyle(fontSize: 16,color:kBlueGrey,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // ReusableTextField(
                //   initialValue:_con!.userData?.professionalInfo?.totalExperience.toString(),
                //   readOnly: true,
                //   hintText: "Total Year of Experience(in Months)",
                //   labelText: "Total Year of Experience(in Months)",
                //   onChanged: (value) {
                //     //_con!.specialization = value;
                //
                //   },
                //   keyboardType: TextInputType.text,
                // ),
                SizedBox(height: 10,),
                ReusableTextField(
                  controller: TextEditingController(text:_con!.userData?.professionalInfo?.preferredIndustry ),
                  //initialValue:_con!.userData?.professionalInfo?.preferredIndustry,
                  readOnly: true,
                  hintText: "Preferred Industry",
                  labelText: "Preferred Industry",
                  onChanged: (value) {
                    //_con!.specialization = value;

                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10,),
                ReusableTextField(
                  controller: TextEditingController(text:_con!.userData?.professionalInfo?.preferredFunction ),
                  //initialValue:_con!.userData?.professionalInfo?.preferredIndustry,
                  readOnly: true,
                  hintText: "Preferred Function",
                  labelText: "Preferred Function",
                  onChanged: (value) {
                    //_con!.specialization = value;

                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10,),
                ReusableTextField(
                  controller: TextEditingController(text:_con!.userData?.professionalInfo?.keySkills?[0].toString() ),
                  //initialValue:_con!.userData?.professionalInfo?.preferredIndustry,
                  readOnly: true,
                  hintText: "KeySkills",
                  labelText: "Keyskills",
                  onChanged: (value) {
                    //_con!.specialization = value;

                  },
                  keyboardType: TextInputType.text,
                ),
            // ReusableDropDown(
            //
            //       validate: (month) {
            //         if (month == null) {
            //           return 'Experience Month is required';
            //         }
            //       },
            //       hintText:_con!.userData?.professionalInfo?.preferredIndustry,// 'preferredIndustry',
            //      // options: _con!.preferedIndustryList,
            //       value:null,//_con!.userData?.professionalInfo?.preferredIndustry,
            //       onChanged: (value) {
            //         setState(() {
            //          // _con!.pr = value;
            //         });
            //       },
            //     ),

                // SizedBox(height: 10,),
                // ReusableDropDown(
                //   validate: (month) {
                //     if (month == null) {
                //       return 'Experience Month is required';
                //     }
                //   },
                //   hintText: _con!.userData?.professionalInfo?.preferredFunction,//'preferredFunction',
                //   options: _con!.preferedFunctionList,
                //   value:null,//_con!.userData?.professionalInfo?.preferredFunction,
                //   onChanged: (value) {
                //     setState(() {
                //       // _con!.pr = value;
                //     });
                //   },
                // ),
               // SizedBox(height: 10,),
               //  ReusableDropDown(
               //    validate: (month) {
               //      if (month == null) {
               //        return 'Experience Month is required';
               //      }
               //    },
               //    hintText:_con!.userData?.professionalInfo?.keySkills?[0].toString(),// 'Ketskills',
               //    options: _con!.preferedIndustryList,
               //    value:null,//_con!.userData?.professionalInfo?.preferredIndustry,
               //    onChanged: (value) {
               //      setState(() {
               //         //_con!.skill = value;
               //      });
               //    },
               //  ),



                SizedBox(height: 50,),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _con!.userData?.professionalInfo?.jobDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    var jobDetail = _con!.userData!.professionalInfo!.jobDetails![index];
                    return Container(
                      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableTextField(

                            initialValue:jobDetail.jobTitle,
                            readOnly: true,
                            //controller: name_controller,
                            // validate: (name) {
                            //   if (name!.isEmpty) {
                            //     Alert.showSnackbar('Full Name is required', context);
                            //     //return 'Full Name is required';
                            //   }
                            // },

                            hintText: "JobTitle",
                            labelText: "JobTitle",
                            onChanged: (value) {
                              //_con!.educationType = value;



                            },
                            keyboardType: TextInputType.text,
                          ),

                          // Text(
                          //   'Education Type: ${educationDetail.educationType ?? 'Empty'}',
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          SizedBox(height: 10),

                          ReusableTextField(
                            initialValue:jobDetail.employer,
                            readOnly: true,
                            hintText: "Employer",
                            labelText: "Employer",
                            onChanged: (value) {
                              //_con!.specialization = value;

                            },
                            keyboardType: TextInputType.text,
                          ),

                          // Text(
                          //   'Specialization: ${educationDetail.specialization ?? 'Empty'}',
                          //   style: TextStyle(fontSize: 16),
                          // ),

                          SizedBox(height: 10),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(right: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:jobDetail.startDate ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'StartDate' ,
                                          labelText:'startDate',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),

                                          suffixIcon: Icon(Icons.calendar_month_outlined)
                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Startdate: ${educationDetail.startDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(left: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:jobDetail.endDate ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'EndDate' ,
                                          labelText:'EndDate',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),

                                          suffixIcon: Icon(Icons.calendar_month_outlined)
                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Enddate: ${educationDetail.endDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),
                            ],

                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(right: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:jobDetail.Salary.toString() ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'Salary' ,
                                          labelText:'Salary',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),


                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Startdate: ${educationDetail.startDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),
                              SizedBox(width: 6,),
                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(left: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:jobDetail.salaryType ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'SalaryType' ,
                                          labelText:'SalaryType',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),



                                  ),
                                ),
                              ),

                              ),],

                          ),
                          SizedBox(height: 10,),
                          ReusableTextField(
                            initialValue:jobDetail.jobSummary ?? 'Empty',
                            readOnly: true,
                            hintText: "Job Summary",
                            labelText: "Job Summary",
                            onChanged: (value) {
                              //_con!.awards = value;

                            },
                            keyboardType: TextInputType.text,
                          ),


                          SizedBox(height: 50,)


                        ],
                      ),
                    );
                  },
                ),

                //todo check below this
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   addAutomaticKeepAlives: true,
                //   itemCount: _con!.userData?.educationalInfo?.educationDetails?.length,
                //   itemBuilder: (context, index) => ExpansionTile(
                //     trailing: IconButton(
                //         icon: Icon(Icons.delete),
                //         onPressed: () {
                //           setState(() {
                //             _con!.educations.removeAt(index);
                //           });
                //         }),
                //     maintainState: true,
                //     title: Container(
                //       padding:
                //       EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //       child: Row(
                //         children: [
                //           Icon(Icons.school),
                //           SizedBox(
                //             width: 15,
                //           ),
                //           Text('school'),
                //           Text(
                //             '${_con!.userData!.educationalInfo!.educationDetails?[index].qualification}',
                //             style: TextStyle(fontSize: 12),
                //           )
                //         ],
                //       ),
                //     ),
                //     children: [
                //       Container(
                //         margin:
                //         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //         child: Column(
                //           children: [
                //             ReusableCardContainer(
                //               title: 'Qualification: ',
                //               value: _con!.userData!.educationalInfo!.educationDetails?[index].qualification==
                //                   null
                //                   ? 'Empty'
                //                   : _con!.userData!.educationalInfo!.educationDetails?[index].qualification
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             ReusableCardContainer(
                //               title: 'Specialization: ',
                //               value: _con!.userData!.educationalInfo!.educationDetails?[index].specialization ==
                //                   null
                //                   ? 'Empty'
                //                   : _con!.userData!.educationalInfo!.educationDetails?[index].specialization
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   'University/School: ',
                //                   style: TextStyle(fontSize: 12),
                //                 ),
                //                 SizedBox(
                //                   width: 10,
                //                 ),
                //                 Flexible(
                //                   child: Text(
                //                     "${_con!.userData!.educationalInfo!.educationDetails![index].university}",
                //                     // _con!.userData!.educationalInfo!.educationDetails?[index].university ==null
                //                     //     ? 'Empty'
                //                     //     : _con!.userData!.educationalInfo!.educationDetails?[index].university,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: TextStyle(
                //                         color: Colors.blue, fontSize: 12),
                //                   ),
                //                 )
                //               ],
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             ReusableCardContainer(
                //               title: 'Passing Year: ',
                //               value:  _con!.userData!.educationalInfo!.educationDetails?[index].endDate ==
                //                   null
                //                   ? 'Empty'
                //                   :  _con!.userData!.educationalInfo!.educationDetails?[index].endDate
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Container(
                //               height: 70,
                //               child: Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'Awards and \nAchievements: ',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   SizedBox(
                //                     width: 10,
                //                   ),
                //                   Flexible(
                //                     child: Text(
                //                       "${_con!.userData!.educationalInfo!.educationDetails![index].awardsAndAchievement}",
                //                       // _con!.userData!.educationalInfo!.educationDetails?[index].awardsAndAchievement ==
                //                       //     null
                //                       //     ? 'Empty'
                //                       //     :  _con!.userData!.educationalInfo!.educationDetails?[index].awardsAndAchievement,
                //                       overflow: TextOverflow.ellipsis,
                //                       maxLines: 3,
                //                       style: TextStyle(
                //                           color: Colors.blue, fontSize: 12),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
//todo i commented below(manual section) at 11.4.24 19:13
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: _con!.experienceYears == null &&
                            _con!.experienceMonths == null
                            ? ''
                            : _con!.experienceMonths != '0' ||
                            _con!.experienceYears != '0'
                            ? 'Job Experience +'
                            : 'Add Experience +',
                        style: TextStyle(color: kBlueGrey, fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                insetPadding: EdgeInsets.zero,
                                title: Text('Experience Card'),
                                content: CardView(
                                  user: _user,
                                ),
                                actions: [
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 12,color: kBlueGrey),
                                      )),
                                  MaterialButton(
                                      onPressed: () {
                                        _con!.users.add(CardView(
                                          user: _user,
                                        ));
                                         //onAddForm();
                                        Navigator.of(context).pop();
                                        _user = User();
                                        setState(() {});
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(fontSize: 12,color: kBlueGrey),
                                      ))
                                ],
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
                  itemCount: _con!.users.length,
                  itemBuilder: (context, index) {
                    var savedUser = _con!.users[index].user!;
                    return Container(
                      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableTextField(

                            initialValue:savedUser.jobTitle,
                            readOnly: true,
                            //controller: name_controller,
                            // validate: (name) {
                            //   if (name!.isEmpty) {
                            //     Alert.showSnackbar('Full Name is required', context);
                            //     //return 'Full Name is required';
                            //   }
                            // },

                            hintText: "JobTitle",
                            labelText: "JobTitle",
                            onChanged: (value) {
                              //_con!.educationType = value;



                            },
                            keyboardType: TextInputType.text,
                          ),

                          // Text(
                          //   'Education Type: ${educationDetail.educationType ?? 'Empty'}',
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          SizedBox(height: 10),

                          ReusableTextField(
                            initialValue:savedUser.employerController,
                            readOnly: true,
                            hintText: "Employer",
                            labelText: "Employer",
                            onChanged: (value) {
                              //_con!.specialization = value;

                            },
                            keyboardType: TextInputType.text,
                          ),

                          // Text(
                          //   'Specialization: ${educationDetail.specialization ?? 'Empty'}',
                          //   style: TextStyle(fontSize: 16),
                          // ),

                          SizedBox(height: 10),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(right: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:savedUser.startDate ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'StartDate' ,
                                          labelText:'startDate',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),

                                          suffixIcon: Icon(Icons.calendar_month_outlined)
                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Startdate: ${educationDetail.startDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(left: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:savedUser.endDate ?? 'Empty' ,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                          hintText:'EndDate' ,
                                          labelText:'EndDate',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: kGreyColor),
                                              borderRadius: BorderRadius.circular(10)),

                                          suffixIcon: Icon(Icons.calendar_month_outlined)
                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Enddate: ${educationDetail.endDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),
                            ],

                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [

                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(right: 5),

                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue:savedUser.salaryController ?? 'Empty' ,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                        hintText:'Salary' ,
                                        labelText:'Salary',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: kGreyColor),
                                            borderRadius: BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: kGreyColor),
                                            borderRadius: BorderRadius.circular(10)),


                                      )

                                  ),
                                ),
                              ),
                              // Text(
                              //   'Startdate: ${educationDetail.startDate ?? 'Empty'}',
                              //   style: TextStyle(fontSize: 16),
                              // ),
                              SizedBox(width: 6,),
                              Expanded(
                                child: Container(

                                  padding: EdgeInsets.only(left: 5),

                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:savedUser.salaryPer ?? 'Empty' ,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                      hintText:'SalaryType' ,
                                      labelText:'SalaryType',
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: kGreyColor),
                                          borderRadius: BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: kGreyColor),
                                          borderRadius: BorderRadius.circular(10)),



                                    ),
                                  ),
                                ),

                              ),],

                          ),
                          SizedBox(height: 10,),
                          ReusableTextField(
                            initialValue:savedUser.jobSummary ?? 'Empty',
                            readOnly: true,
                            hintText: "Job Summary",
                            labelText: "Job Summary",
                            onChanged: (value) {
                              //_con!.awards = value;

                            },
                            keyboardType: TextInputType.text,
                          ),


                          SizedBox(height: 50,)


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
                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=>JobPreferenceScreen(candidateId:widget.candidateId!,)));


                        }))

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     PreviousButton(
                //         title: 'Previous',
                //         onPressed: () {
                //           Navigator.of(context).pop({
                //             "highestQualification": _con!.highestQualification,
                //             "educations": _con!.educations,
                //           });
                //         }),
                //     // ReusableButton(
                //     //     title: 'Next',
                //     //     onPressed: () {
                //     //       final isValid = _formkey.currentState!.validate();
                //     //       if (!isValid) {
                //     //         return;
                //     //       } else {
                //     //         if (_con!.highestQualification != "Uneducated" &&
                //     //             _con!.educations.length == 0) {
                //     //           Alert.showSnackbar(
                //     //               'Atleast add one Education info.',
                //     //               context);
                //     //         } else {
                //     //           _con!.updateCandidate(context, widget.candidateId!);
                //     //         }
                //     //       }
                //     //     }),
                //   ],
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void onAddForm() {
    print("Adding a new form");
   setState(() {
      var _user = User();
      _con!.users.add(CardView(
        user: _user,
      ));
    });
  }

  void ondelete(int index) {
    setState(() {
      _con!.users.removeAt(index);
    });
  }


}
