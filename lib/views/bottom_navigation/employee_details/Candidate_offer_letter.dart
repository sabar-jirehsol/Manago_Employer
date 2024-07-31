import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/previous_button.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/applicants.dart/offer_letter_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/controller_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

import 'employee_add/steps.dart';

class CandidateOfferLetter extends StatefulWidget {
  final String? candidateId;
  // final  offeredBasicSalary;
  // final offeredGrossSalary;
  // final String? note;
  // final String? designation;
  // final String? joiningDate;
  // final String? job;
  // final bool? hidePreviousButton;

  const CandidateOfferLetter({
    Key? key,
    this.candidateId,
    // this.offeredBasicSalary,
    // this.offeredGrossSalary,
    // this.note,
    // this.designation,
    // this.joiningDate,
    // this.job,
    // this.hidePreviousButton,
  }) : super(key: key);
  @override
  _OfferLetterState createState() => _OfferLetterState();
}

class _OfferLetterState extends StateMVC<CandidateOfferLetter> {
  OfferLetterController? _con;
  _OfferLetterState() : super(OfferLetterController()) {
    _con = controller as OfferLetterController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getAllJobs(context);
  }

  @override
  Widget build(BuildContext context) {
    // widget.offeredBasicSalary != null
    //     ? _con!.offeredBasicSalary = widget.offeredBasicSalary
    //     : null;
    // widget.offeredGrossSalary != null
    //     ? _con!.offeredGrossSalary = widget.offeredGrossSalary
    //     : null;
    // widget.note != null ? _con!.note = widget.note : null;
    // widget.designation != null ? _con!.designation = widget.designation : null;
    // widget.joiningDate != null ? _con!.joiningDate = widget.joiningDate : null;
    //
    // widget.job != null ? _con!.job = widget.job : null;

    return Scaffold(
      key: _con!.scaffoldKey,
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
          'Offer Letter',
          style: TextStyle(
              color: kSubtitleText, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          // TextButton(
          //   onPressed: () {},
          //   child: Text(
          //     'Skip',
          //     style: TextStyle(
          //       color: Color(0xff3848F1),
          //       fontWeight: FontWeight.w600,
          //       fontSize: 18,
          //     ),
          //   ),
          // ),
        ],

      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Steppers(activeStep: 4,),

                SearchableDD(
                  validate: (state) {
                    if (state == null) {
                      return 'Select Job';
                    }
                  },
                  hintText: 'Search Job',
                  label: 'Job',
                  items: _con!.newJobList,
                  selectedItem: _con!.job,
                  onChanged: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _con!.job = value;
                      _con!.getJobid(value!);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: _con!.designation,
                  onChanged: (value) => _con!.designation = value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Designation ',
                    labelText: 'Designation',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: _con!.offeredBasicSalary,
                  onChanged: (value) => _con!.offeredBasicSalary = value,
                  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Offered Basic Salary Per Anum',
                    labelText: 'Offered Basic Salary Per Anum',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // TextFormField(
                //   initialValue: _con!.offeredGrossSalary.toString(),
                //   onChanged: (value) => _con!.offeredGrossSalary = value as int?,
                //   style: TextStyle(fontSize: 18),
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(
                //     hintText: 'Offered Gross Salary',
                //     labelText: 'Offered Gross Salary',
                //     contentPadding:
                //         EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                //     enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: kPurple,
                //         ),
                //         borderRadius: BorderRadius.circular(10)),
                //     focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: kPurple,
                //         ),
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: _con!.note,
                  onChanged: (value) => _con!.note = value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Note',
                    labelText: 'Note',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),


                SizedBox(height: 20),
                //Salary Date
                TextFormField(
                  initialValue: _con!.joiningDate,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? jd = await DatePickerClass.selectDate(
                      context,
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (jd != null) {
                      _con!.joiningDate = _con!.formatter.format(jd);
                    }
                    setState(() {});
                  },
                  onChanged: (value) => _con!.joiningDate = value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon:Icon(Icons.calendar_today), onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? jd = await DatePickerClass.selectDate(
                        context,
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (jd != null) {
                        _con!.joiningDate = _con!.formatter.format(jd);
                      }
                      setState(() {});


                    },),
                    hintText: _con!.joiningDate == null
                        ? 'Joining Date'
                        : _con!.joiningDate,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // //widget.hidePreviousButton!
                //     //     ? Container():
                //     // PreviousButton(
                //     //         title: 'Previous',
                //     //         onPressed: () {
                //     //           // Navigator.of(context).pop();
                //     //           Navigator.of(context).pop({
                //     //             "offeredBasicSalary": _con!.offeredBasicSalary,
                //     //             "offeredGrossSalary": _con!.offeredGrossSalary,
                //     //             "note": _con!.note,
                //     //             "designation": _con!.designation,
                //     //             "joiningDate": _con!.joiningDate,
                //     //             "job": _con!.job
                //     //           });
                //     //         }),
                //     ReusableButton(
                //       title: 'Save',
                //       onPressed: () {
                //         _con!.addEmployee(context, widget.candidateId!);
                //       },
                //     ),
                //   ],
                // ),
                SizedBox(height: 20),

                Align(
                    alignment: Alignment.center,
                    child: ReusableButton(
                        title: 'Save',
                        onPressed: () {


                          _con!.addEmployee(context, widget.candidateId!);


                           }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
