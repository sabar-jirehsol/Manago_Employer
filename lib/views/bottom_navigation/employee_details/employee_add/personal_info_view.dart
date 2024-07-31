import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_radio_button.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/employee/personal_info_controller.dart';
import 'package:manago_employer/models/education.dart';
import 'package:manago_employer/provider/profile.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/professional_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/steps.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../../components/subscription/active_subscription_plan.dart';
import '../../../../components/subscription/cancel_subscription.dart';
import '../../more/company_profile.dart';
import 'education_info_view.dart';
import 'job_preference_view.dart';
// import '../../job/job_professional_info.dart';
// import '../../more/offer_letters/AddOfferLetter.dart';
// import 'education_info_view.dart';
// import 'job_preference_view.dart';

class PersonalInfoScreen extends StatefulWidget {
  static const String id = 'personal_info_screen_id';
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends StateMVC<PersonalInfoScreen> {
  PersonalInfoController? _con;
  _PersonalInfoScreenState() : super(PersonalInfoController()) {
    _con = controller as PersonalInfoController?;
  }

  TextEditingController stateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final pageController = PageController(initialPage: 0);



  Future<void> apiRefresh() async {
    // Call getCandidateDetails and await it
    await _con!.getCandidateDetails(_con!.candidateId);

    setState(() { });
  }


  @override
  void initState() {
    super.initState();
    _con!.loadStates(context);
    _con!.maritialStatus;
    _con!.getCandidateDetails(_con!.candidateId);
    apiRefresh();

   setState(() {_con!.getCandidateDetails(_con!.candidateId); });
    _con!.getCandidateDetails(_con!.candidateId).then((_) {
      setState(() {
       // _initialNameValue = _con!.userData?.personalInfo?.name ?? '';

      }); // Trigger a rebuild after fetching data
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
                )),
          ),
        ),
        title: Text(
          'Personal Information',
          style: TextStyle(
              color: kSubtitleText, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      key: _con!.scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Steppers(activeStep: 0,),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                //   width: MediaQuery.of(context).size.width / 4,
                //   child:Steppers(activeStep: 0,),
                //   // child:StepProgressIndicator(
                //   //     size: 6,
                //   //     totalSteps: 5,
                //   //     currentStep: 1,
                //   //
                //   //     selectedColor: kPrimaryColor,
                //   //     unselectedColor: Colors.grey.shade300),
                // ),
                // ReusableTextField(
                //   limitnum: 10,  // todo i added limit num 5-03-2024
                //   //maxlength: 10,
                //   validate: (mobile) {
                //     if (mobile!.isEmpty) {
                //       Alert.showSnackbar('Phone is required.', context);
                //      // return 'Phone is required.';
                //     } else if (mobile.toString().length < 10) {
                //       Alert.showSnackbar('Phone is incorrect.', context);
                //      // return 'Phone number is incorrect ';
                //     } else if (_con!.mobile!.contains(',') ||
                //         _con!.mobile!.contains('.') ||
                //         _con!.mobile!.contains('-') ||
                //         _con!.mobile!.contains('_')) {
                //       Alert.showSnackbar('Phone number is wrong.', context);
                //       //return 'Phone number is wrong';
                //     }
                //     else{
                //       print("API calling");//Todo Api is not calling that's why we get a null error
                //       _con!.saveCandidateviamobile(_con!.mobile,context);}
                //   },
                //   hintText: "Phone",
                //   labelText: "Phone",
                //   onChanged: (value) => _con!.mobile = value,
                //   keyboardType: TextInputType.number,
                // ),
                ReusableTextField(
                  limitnum: 10,  // todo i added limit num 5-03-2024
                  hintText: "Phone",
                  labelText: "Phone",
                  onChanged: (value) {
                    _con!.mobile = value;
                    if (value.length == 10) {
                      // Perform further validation if needed
                      _con!.saveCandidateviamobile(value, context);

                    }
                  },
                  keyboardType: TextInputType.number,
                ),

                SizedBox(
                  height: 20,
                ),

                Consumer<ProfileImage>(
                  builder: (context, profileImage, child) => ReusableTextField(
                    controller:TextEditingController(text:_con!.userData?.personalInfo?.name),
                     //initialValue:_con!.userData?.personalInfo?.name??"",
                    //controller: name_controller,
                    // validate: (name) {
                    //   if (name!.isEmpty) {
                    //     Alert.showSnackbar('Full Name is required', context);
                    //     //return 'Full Name is required';
                    //   }
                    // },
                  keyboardType:TextInputType.visiblePassword,
                    hintText: "Full Name",
                    labelText:"Full Name",
                    onChanged: (value) {
                      _con!.name = value;
                      print(_con!.name);
                      print("HHHHHHH${ _con!.userData?.personalInfo!.name}");


                    },
                    //keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // ReusableTextField(
                //   limitnum: 10,  // todo i added limit num 5-03-2024
                //   //maxlength: 10,
                //   // validate: (mobile) {
                //   //   if (mobile!.isEmpty) {
                //   //     Alert.showSnackbar('Phone is required.', context);
                //   //    // return 'Phone is required.';
                //   //   } else if (mobile.toString().length < 10) {
                //   //     Alert.showSnackbar('Phone is incorrect.', context);
                //   //    // return 'Phone number is incorrect ';
                //   //   } else if (_con!.mobile!.contains(',') ||
                //   //       _con!.mobile!.contains('.') ||
                //   //       _con!.mobile!.contains('-') ||
                //   //       _con!.mobile!.contains('_')) {
                //   //     Alert.showSnackbar('Phone number is wrong.', context);
                //   //     //return 'Phone number is wrong';
                //   //   }
                //   // },
                //   hintText: "Phone",
                //   labelText: "Phone",
                //   onChanged: (value) => _con!.mobile = value,
                //   keyboardType: TextInputType.number,
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                ReusableTextField(
                  controller:TextEditingController(text:_con!.userData?.personalInfo?.email),
                  //initialValue: _con!.userData?.personalInfo?.email??"email",

                  //   if (email!.isEmpty) {
                  //     Alert.showSnackbar('Email is required.', context);
                  //    // return 'Email is required.';
                  //   } else if ((_con!.email!.contains('@') == false) ||
                  //       (_con!.email!.contains('.') == false)) {
                  //     Alert.showSnackbar('Email format is wrong', context);
                  //     //return 'Email format is wrong';
                  //   }
                  // },
                  keyboardType:TextInputType.visiblePassword,
                  hintText: "Email Address",
                  labelText: "Email Address",
                  onChanged: (value) => _con!.email = value,
                 // keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchableDD(
                          // validate: (state) {
                          //   if (state == null) {
                          //     Alert.showSnackbar('Gender is required', context);
                          //    // return 'Gender is required';
                          //   }
                          // },
                          showClearButton: false,
                          hintText: 'Select Gender',
                          label: 'Gender',
                          items: ['Male', 'Female', 'Others'],
                          selectedItem: _con!.userData?.personalInfo?.gender??"gender",//_con!.gender,
                          onChanged: (value) {
                            setState(() {
                              _con!.gender = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20),
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _con!.dob == null
                                      ? 'Date of Birth'
                                      : '${_con!.dob}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Icon(Icons.calendar_month_outlined)
                              ],
                            ),
                          ),
                          onPressed: () async {
                            DateTime birthDate =
                                await _con!.selectDate(context, DateTime.now());
                            final df = new DateFormat('dd-MMM-yyyy');
                            _con!.dob = df.format(birthDate);
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller:TextEditingController(text:_con!.userData?.personalInfo?.address),
                  //initialValue: _con!.userData?.personalInfo?.address??"address",
                  // validator: (address) {
                  //   if (address!.isEmpty) {
                  //     Alert.showSnackbar('Address is required', context);
                  //     //return 'Address is required';
                  //   }
                  // },
                  keyboardType:TextInputType.visiblePassword,
                  onChanged: (value) => _con!.address = value,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Full Address',
                    labelText: 'Full Address',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SearchableDD(
                        // validate: (state) {
                        //   if (state == null) {
                        //     Alert.showSnackbar('State is required', context);
                        //    // return 'State is required';
                        //   }
                        // },
                        showClearButton: false,
                        hintText: 'Search State',
                        label: 'State',
                        items: _con!.newStates,
                        selectedItem: _con!.newState??null,
                        onChanged: (value) {
                          setState(() {
                            _con!.newState = value;
                            _con!.loadCities(_con!.newState!);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SearchableDD(
                        // validate: (city) {
                        //   if (_con!.city == null) {
                        //     Alert.showSnackbar('City is required', context);
                        //     //return 'City is required';
                        //   }
                        // },
                        showClearButton: false,
                        hintText: 'Search City',
                        label: 'City',
                        items: _con!.cities,
                        selectedItem: _con!.city??null,
                        onChanged: (value) {
                          _con!.city = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),








                TextFormField(
                  controller:TextEditingController(text:_con!.userData?.personalInfo?.pincode.toString()),
                  //initialValue:_con!.userData?.personalInfo?.pincode.toString()!=null?_con!.userData!.personalInfo?.pincode.toString():"pin",

                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  keyboardType:TextInputType.visiblePassword,
                  // validator: (pincode) {
                  //   if (pincode!.isEmpty) {
                  //     Alert.showSnackbar('Postal Code is required', context);
                  //     //return 'Postal Code is required';
                  //   } else if (pincode.length < 6) {
                  //     Alert.showSnackbar('Postal Code should be of 6 digits.', context);
                  //     //return 'Postal Code should be of 6 digits.';
                  //   }
                  // },
                  onChanged: (value) => _con!.pincode = value,
                  //keyboardType: TextInputType.number,
                  //maxLength: 6,
                  decoration: InputDecoration(
                      hintText: 'Postal Code',
                      labelText: 'Postal Code',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreyColor),
                          borderRadius: BorderRadius.circular(10))),
                ),

                // SizedBox(
                //   height: 10,
                // ),
                //TODO: date of birth

                SizedBox(height: 20),
                // TODO: marital status

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: kGreyColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marital Status:',
                        style: TextStyle(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Married',
                                  groupValue: _con!.maritialStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      _con!.maritialStatus = value!;

                                    });
                                  },
                                ),
                                Text(
                                  'Married',
                                  style: TextStyle(fontSize: 16), // Adjust text size
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10), // Adjust space between texts
                          Expanded(
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'Unmarried',
                                  groupValue: _con!.maritialStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      _con!.maritialStatus = value!;


                                    });
                                  },
                                ),
                                Text(
                                  'Unmarried',
                                  style: TextStyle(fontSize: 16), // Adjust text size
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ) ,












                SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                  controller: TextEditingController(text:_con!.userData?.personalInfo?.aadhar ??null),
                  //initialValue: _con!.userData?.personalInfo?.aadhar ??null, // Providing an empty string as a fallback
                  maxlength: 12,
                  // validate: (aadhar) {
                  //   // if (aadhar.isEmpty) {
                  //   //   return 'Aadhar is required.';
                  //   // } else if (aadhar.toString().length < 12) {
                  //   //   return 'Aadhar number is incorrect ';
                  //   // } else if (_con!.aadhar.contains(',') ||
                  //   //     _con!.aadhar.contains('.') ||
                  //   //     _con!.aadhar.contains('-') ||
                  //   //     _con!.aadhar.contains('_')) {
                  //   //   return 'Aadhar number is wrong';
                  //   // }
                  //
                  //
                  // },
                  keyboardType:TextInputType.visiblePassword,
                  hintText: "Aadhar Card Number(optional)",
                  labelText: "Aadhar Card Number(optional)",
                  onChanged: (value) => _con!.aadhar = value,
                  //keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Consumer<ProfileImage>(
                    builder: (context, profileImage, child) => ReusableButton(
                        title: 'Continue',
                        onPressed: () {


                          if (_con!.mobile==null) {
                            return  Alert.showSnackbar('Phone is required.', context);
                          } else if (_con!.mobile.toString().length < 10) {
                            return  Alert.showSnackbar('Phone is incorrect.', context);

                          } else if (_con!.mobile!.contains(',') ||
                             _con!.mobile!.contains('.') ||
                             _con!.mobile!.contains('-') ||
                             _con!.mobile!.contains('_')) {
                            return Alert.showSnackbar('Phone number is wrong.', context);

                          } else if (_con!.name == null ||_con!.name!.isEmpty) {
                            return Alert.showSnackbar('Name should not be empty.', context);
                          }

                          else if (_con!.email==null) {
                            Alert.showSnackbar('Email is required.', context);
                            // return 'Email is required.';
                          } else if ((_con!.email!.contains('@') == false) ||
                              (_con!.email!.contains('.') == false)) {
                            Alert.showSnackbar('Email format is wrong', context);
                            //return 'Email format is wrong';
                          } else if (_con!.gender == null) {
                            Alert.showSnackbar('Gender is required', context);
                            // return 'Gender is required';
                          }else if ( _con!.dob==null) {
                             Alert.showSnackbar('Date of birth is required.', context);
                              }else if (_con!.address==null) {
                            Alert.showSnackbar('Address is required', context);
                            //return 'Address is required';
                          } else if (_con!.state == null) {
                            Alert.showSnackbar('State is required', context);
                            // return 'State is required';
                          } else if (_con!.city == null) {
                            Alert.showSnackbar('City is required', context);
                            //return 'City is required';
                          }else if (_con!.pincode==null) {
                            Alert.showSnackbar('Postal Code is required', context);
                            //return 'Postal Code is required';
                          } else if (_con!.pincode!.length < 6) {
                            Alert.showSnackbar('Postal Code should be of 6 digits.', context);
                            //return 'Postal Code should be of 6 digits.';
                          }else if (_con!.maritialStatus == null) {
                            Alert.showSnackbar('Marital Status is required.', context);
                          }else{
                           if (_con!.saveCandidateViaMobile==true){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>EducationalInfoScreen(candidateId:_con!.candidateId)));
                           }
                               _con!.saveCandidate(context);
                              print("STAART SAVE CANDIDATEID BY CANDIDATE ID");



                          }






                          // final isValid = _formKey.currentState!.validate();
                          // if (!isValid) {
                          //   return'';
                          // } else {
                          //   if ( _con!.dob==null) {
                          //     Alert.showSnackbar(
                          //         'Date of birth is required.', context);
                          //   }else if (_con!.maritialStatus == null) {
                          //     Alert.showSnackbar('Marital Status is required.', context);
                          //
                          //   }
                          //   else if (_con!.gender == null) {
                          //     Alert.showSnackbar(
                          //         'Gender is required.',  context);
                          //   }
                          //   else {
                          //     profileImage.changeName(_con!.name!);
                          //     profileImage.changeState(_con!.newState!);
                          //
                          //     _con!.saveCandidate(context);
                          //
                          //   }
                          //}
                        }),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
