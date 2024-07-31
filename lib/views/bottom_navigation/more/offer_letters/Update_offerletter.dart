
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_textField.dart';

import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/update_offerleetterController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../../components/searchable_dropDown.dart';

import '../../../../models/OfferLetterDetailsModel.dart';
import '../../../../utils/date_picker.dart';

class UpdateOfferletter extends StatefulWidget {


  final OfferLetterDatum? offerletterdetails;

  const UpdateOfferletter({Key? key, this.offerletterdetails}) : super(key: key);
  @override
  _UpdateOfferletterState createState() => _UpdateOfferletterState();
}

class _UpdateOfferletterState extends StateMVC<UpdateOfferletter> {
  UpdateOfferletterController? _con;
  _UpdateOfferletterState() : super(UpdateOfferletterController()) {
    _con = controller as UpdateOfferletterController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.offerLetterDetails(widget.offerletterdetails!.id!);


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
            ' Update Offer Letter ',
            style: TextStyle(color: kPrimaryColor),
          ),

        ),


        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ReusableTextField(
                 readOnly: true,
                  initialValue: _con!.userData!.candidateId!.personalInfo!.name,
                  hintText: 'name',
                  onChanged: (value) {

                  },
                ),


              // SizedBox(height: 20,),
              //   TextFormField(
              //     //key: Key("os${_con!.businessName}"),
              //
              //     initialValue: _con!.userData!.employerId!.businessName,
              //     onChanged: (value) {
              //       _con!.businessName= value;
              //       _con!.update_offbusinessname=false;
              //     },
              //     style: TextStyle(fontSize: 18),
              //     decoration: InputDecoration(
              //       labelText: "Business Name",
              //       prefixText: ' ',
              //       prefixStyle:
              //       TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //       hintText: 'Business Name',
              //       contentPadding:
              //       EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: kGreyColor,
              //           ),
              //           borderRadius: BorderRadius.circular(10)),
              //       focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: kGreyColor,
              //           ),
              //           borderRadius: BorderRadius.circular(10)),
              //     ),
              //   ),
              //   _con!.update_offbusinessname?errorText('BusinessName is Required.'):const SizedBox(),

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // initialValue: _con.month,

                  readOnly: true,
                  onTap: () async {
                    DateTime? dob = await DatePickerClass.selectDate(context);
                    if (dob != null) {
                      _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                    }
                    setState(() {
                      _con!.update_offjoininDate=false;
                    });
                  },
                  // onChanged: (value) => _con.month = value,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(

                    hintText: _con!.joiningDate == null  ? _con!.userData!.joiningDate: _con!.joiningDate,
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
                    suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? selectedDate = await DatePickerClass.selectDate(context);
                              if (selectedDate != null) {
                                _con!.joiningDate = DatePickerClass.dateFormatterMethod(selectedDate);
                                setState(() {
                                  _con!.update_offjoininDate=false;
                                });
                              }
                            },
                            icon: Icon(Icons.calendar_today), // Calendar icon
                          ),
                  ),
                ),
                _con!.update_offjoininDate?errorText("Joining Date is Required"):const SizedBox(),



                SizedBox(
                  height: 20,
                ),

                ReusableTextField(
                  labelText: 'Designation',
                 // key: Key("od${_con!.designation}"),
                  initialValue: _con!.userData!.designation,
                  hintText: 'Designation',
                  onChanged: (value) {
                    setState(() {
                      _con!.update_designation=false;
                    });
                    _con!.designation=value;
                  }

                ),
                 _con!.update_designation?errorText("Designation is Required."):const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //key: Key("os${_con!.salary}"),
                  initialValue: _con!.userData!.offeredSalary.toString(),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    //FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                    LengthLimitingTextInputFormatter(9),
                  ],
                  onChanged: (value) {
                    _con!.salary = value;
                    setState(() {_con!.update_offsalary=false; });
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Offered Salary',
                    prefixText: '₹  ',
                    prefixStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    hintText: 'Offered Salary',
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
                _con!.update_offsalary?errorText('Salary is Required and it should not be 0 '):const SizedBox(),

                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue:  _con!.userData!.description,
                  maxLines: 3,
                  onChanged: (value) {_con!.description = value;
                  setState(() {

                    _con!.update_offdescription=false;
                  });
                  },
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Description',
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
                ),
                _con!.update_offdescription? errorText('Description is Required.') :const SizedBox(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Center(
                    child:   ReusableButton(
                      onPressed: () {
                        print(_con!.businessName);
                        print(_con!.joiningDate);
                        print(_con!.designation);
                        print(_con!.salary);
                        print(_con!.description);
                        // print(_con!.userData!.id);
                        // print(_con!.userData!.employerId!.id);
                        // print(_con!.userData!.employeeId);
                        // print(_con!.userData!.candidateId!.id);
                        setState(() { });
                        _con!.updateOfferletter(context);
                      },
                      title: 'Update',
                    )
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
