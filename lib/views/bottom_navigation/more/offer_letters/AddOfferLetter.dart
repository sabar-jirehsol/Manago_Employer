import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/AddOfferLetterController.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../components/searchable_dropDown.dart';
import '../../../../utils/success_dialogbox.dart';

class AddOfferLetter extends StatefulWidget {
  @override
  _AddOfferLetterState createState() => _AddOfferLetterState();
}

class _AddOfferLetterState extends StateMVC<AddOfferLetter> {
  AddOfferLetterController? _con;

  _AddOfferLetterState() : super(AddOfferLetterController()) {
    _con = controller as AddOfferLetterController?;
  }
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _con!.getEmployeeList();
    _con!.EmployerProfileCompletion(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar:  AppBar(
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
            backgroundColor: Colors.white,
            title: Text(
              ' Add Offer Letter ',
              style: TextStyle(color: kPrimaryColor),
            ),
            // actions: [
            //   GestureDetector(
            //     onTap: () {
            //       // Add your skip action here
            //       //_con!.skipScreen(context, widget.candidateId!);
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 20),
            //       child: Text(
            //         'Skip',
            //         style: TextStyle(color: kBlueColor,fontSize: 20,fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ],
          ),


          body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // ReusableDropDown(
                //   hintText: 'Select Employee',
                //   options: ["Jigyasa Singh(7808388162)"],//_con!.employeeNamesList,
                //   onChanged: (value) {
                //     setState(() {
                //       _con!.employee = value;
                //       _con!.getEmployeeId(value);
                //     });
                //   },
                //   value: _con!.employee,
                // ),






                SearchableDD(
                  hintText: 'Select Applicant',
                  label: 'Select Applicant',
                  items: _con!.employeeNamesList,
                  selectedItem: _con!.employee,
                  onChanged: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {

                      _con!.employee = value;
                      _con!.getEmployeeId(value);
                      _con!.offemp=false;
                      _con!.offdesignation=false;
                    });

                  },
                ),




                _con!.offemp?errorText('Employee is required'):const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: Key("oj${_con!.joiningDate}"),
                  initialValue: _con!.joiningDate,
                  readOnly: true,
                  onTap: () async {
                    DateTime? dob = await DatePickerClass.selectDate(context);
                    if (dob != null) {
                      _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                    }
                    setState(() {  _con!.offjoindate=false;});
                  },
                  onChanged: (value) => _con!.joiningDate = value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: _con!.joiningDate == null ? 'Joining Date' : _con!.joiningDate,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await DatePickerClass.selectDate(context);
                        if (selectedDate != null) {
                          _con!.joiningDate = DatePickerClass.dateFormatterMethod(selectedDate);
                          setState(() {
                            _con!.offjoindate=false;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_today), // Calendar icon
                    ),
                  ),
                ),
               _con!.offjoindate?errorText('Joining date is required.'):const SizedBox(),

                SizedBox(
                  height: 20,
                ),

                ReusableTextField(
                  //key: Key("od${_con!.designation}"),
                  controller: TextEditingController(text:  _con!.designation),
                  //initialValue: _con!.designation,
                  hintText: 'Designation',
                  onChanged: (value) {
                    _con!.designation=value;
                    _con!.offdesignation=false;
                  }

                ),

                _con!.offdesignation?errorText("Designation is required."):const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    //FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                    LengthLimitingTextInputFormatter(9),
                  ],
                 // key: Key("os${_con!.salary}"),
                  keyboardType: TextInputType.number,
                  initialValue:"", //_con!.salary.toString(),
                  onChanged: (value){_con!.salary = value;
                    _con!.offsalary=false;
                    },
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(

                   // prefixText: '₹  ',
                    prefixStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    hintText: '₹ Offered Salary Per Anum',

                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                _con!.offsalary?errorText('Salary is required.and it should not be 0'):const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                TextField(

                  maxLines: 4,
                  onChanged: (value) {_con!.description = value;
                    _con!.offdescription=false;
                    } ,
                  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                ),_con!.offdescription?errorText("Description is Required."): const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Center(
                    child: Row(
                      children: [
                        ReusableButton(
                          title: 'Cancel',
                          onPressed: () {
                            // we need add something this is from date(6.1.24)
                          },
                        ),
                        SizedBox(width: 30,),
                        ReusableButton(
                          onPressed: () async{
                            await   _con!.EmployerProfileCompletion(context);
                            if(_con!.isprofilecompletion==true) {
                              setState(() {});
                              _con!.addOfferLetter(context);
                            }else{
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
                                            message:'Employer data incomplete. Please fill in your details in the profile section.' ,
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
                          },
                          title: 'Save',
                        )
                      ],
                    ),
                  ),
                ),






              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$text', style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
