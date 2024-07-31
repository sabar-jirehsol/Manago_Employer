import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';

import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';


import '../../../../controllers/expereince/update_experience_controller.dart';
import '../../../../models/OfferLetterDetailsModel.dart';

class UpdateExperienceletter extends StatefulWidget {
  final OfferLetterDatum? offerletterdetails;

  const UpdateExperienceletter({Key? key, this.offerletterdetails}) : super(key: key);
  @override
  _UpdateExperienceletterState createState() => _UpdateExperienceletterState();
}

class _UpdateExperienceletterState extends StateMVC<UpdateExperienceletter> {
  UpdateExperienceletterController? _con;

  _UpdateExperienceletterState() : super(UpdateExperienceletterController()) {
    _con = controller as UpdateExperienceletterController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.offerLetterDetails(widget.offerletterdetails!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      appBar: AppBar(
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
        backgroundColor: Colors.white,
        title: Text(
          'Update Experience Letter',
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
                labelText: 'Employee Name',
                //hintText: 'Designation',
                //key: Key('ed${_con!.designation}'),
                initialValue:_con!.userData!.candidateId!.personalInfo!.name,
                //onChanged: (value) => _con!.designation,
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(

                      key: Key('ej${_con!.joiningDate}'),
                      initialValue: _con!.joiningDate,
                      readOnly: true,
                      onTap: () async {
                        DateTime? dob =
                        await DatePickerClass.selectDate(context);
                        if (dob != null) {
                          _con!.joiningDate =
                              DatePickerClass.dateFormatterMethod(dob);
                        }
                        setState(() {});
                      },
                      onChanged: (value) {
                        _con!.joiningDate = value;
                        _con!.update_expjoindate=false;
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        suffixIcon:IconButton(onPressed: () async{
                          DateTime? dob =
                              await DatePickerClass.selectDate(context);
                          if (dob != null) {
                            _con!.joiningDate =
                                DatePickerClass.dateFormatterMethod(dob);
                          }
                          setState(() {});
                        },icon: Icon(Icons.calendar_today),),
                        labelText: 'Joining Date',
                        hintText: _con!.joiningDate == null
                            ? 'Joining Date'
                            : _con!.joiningDate,
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      key: Key('ej${_con!.releasingDate}'),
                      initialValue: _con!.releasingDate,
                      readOnly: true,
                      onTap: () async {
                        DateTime? dob = await DatePickerClass.selectDate(context,
                            firstDate: _con!.release_joinDate,
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (dob != null) {
                          _con!.releasingDate =
                              DatePickerClass.dateFormatterMethod(dob);
                        }
                        setState(() {});
                      },
                      onChanged: (value) {
                        _con!.releasingDate = value;
                        _con!.update_expreleasingdate=false;
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        suffixIcon:IconButton(onPressed: () async{
                          DateTime? dob = await DatePickerClass.selectDate(context,
                              firstDate: _con!.release_joinDate,
                              lastDate: DateTime(DateTime.now().year + 1));
                          if (dob != null) {
                            _con!.releasingDate =
                                DatePickerClass.dateFormatterMethod(dob);
                          }
                          setState(() {});
                        },icon: Icon(Icons.calendar_today),),
                        labelText: 'Relieving date',
                        hintText: _con!.releasingDate == null
                            ? 'Releasing Date'
                            : _con!.releasingDate,
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
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(child:_con!.update_expjoindate?errorText('Joining Date is Required.'):const SizedBox(),),
                  Expanded(child:  _con!.update_expreleasingdate?errorText('Releasing Date is Required.'):const SizedBox(), )
                ]

              ),



              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _con!.description,
                maxLines: 3,
                onChanged: (value) {
                  _con!.description = value;
                  _con!.update_expdescription=false;
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
              _con!.update_expdescription?errorText("Description is Required"):const SizedBox(),
              SizedBox(
                height: 20,
              ),

              ReusableTextField(
                labelText: 'Designation',
                hintText: 'Designation',
                key: Key('ed${_con!.designation}'),
                initialValue: _con!.designation,
                onChanged: (value) {
                  _con!.designation=value;

                  _con!.update_expdesignation=false;
                }
              ),
              _con!.update_expdesignation?errorText("Designation is Required"):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   key: Key('es${_con!.salary}'),
              //   initialValue: _con!.salary.toString(),
              //   onChanged: (value) => _con!.salary = value ,
              //   style: TextStyle(fontSize: 18),
              //   decoration: InputDecoration(
              //     labelText: 'Salary',
              //     prefixText: '₹  ',
              //     prefixStyle:
              //     TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //     hintText: 'Offered Salary',
              //     contentPadding:
              //     EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //     enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: kGreyColor,
              //         ),
              //         borderRadius: BorderRadius.circular(10)),
              //     focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: kGreyColor,
              //         ),
              //         borderRadius: BorderRadius.circular(10)),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              ReusableButton(
                onPressed: () {
                  // print(_con!.joiningDate);
                  // print(_con!.releasingDate);
                  // print(_con!.description);
                  // print(_con!.designation);
                 // print(_con!.salary);
                  setState(() { });
                  _con!.updateExperienceletter(context);
                },
                title: 'Update',
              )
            ],
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
