import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/expereince/add_expereince_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class AddExpereince extends StatefulWidget {
  @override
  _AddExpereinceState createState() => _AddExpereinceState();
}

class _AddExpereinceState extends StateMVC<AddExpereince> {
  AddExpereinceController? _con;

  _AddExpereinceState() : super(AddExpereinceController()) {
    _con = controller as AddExpereinceController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getEmployeeList();


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
          'Add Experience Letter',
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
              // ReusableDropDown(
              //   hintText: 'Select Employee',
              //   items: _con!.employeeNamesList,
              //   onSelected: (value) {
              //     setState(() {
              //       _con!.employee = value;
              //       _con!.getEmployeeId(value);
              //     });
              //   },
              //   value: _con!.employee,
              // ),
              SearchableDD(
                hintText: 'Select Employee',
                label: 'Select Employee',
                items: _con!.employeeNamesList,
                selectedItem: _con!.employee,
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _con!.employee = value;
                    _con!.getEmployeeId(value!);

                    _con!.expemp=false;
                    _con!.expjoindate=false;
                    _con!.expdesignation=false;
                  });
                },
              ),
              _con!.expemp?errorText("Employee is required"):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                     // key: Key('ej${_con!.joiningDate}'),
                      initialValue: _con!.joiningDate,
                      readOnly: true,
                      onTap: () async {
                        // DateTime? dob =
                        //     await DatePickerClass.selectDate(context);
                        // if (dob != null) {
                        //   _con!.joiningDate =
                        //       DatePickerClass.dateFormatterMethod(dob);
                        // }
                        // setState(() {
                        //   _con!.expjoindate=false;
                        // });
                      },
                      onChanged: (value) {
                        _con!.joiningDate = value;

                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        suffixIcon:IconButton(onPressed: () {  },icon: Icon(Icons.calendar_today),),
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

                      readOnly: true,
                      onTap: () async {
                        DateTime? dob = await DatePickerClass.selectDate(context,
                            firstDate:_con!.release_joinDate,
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (dob != null) {
                          _con!.releasingDate =
                              DatePickerClass.dateFormatterMethod(dob);
                        }
                        setState(() {

                          _con!.expreleasingdate=false;
                        });
                      },
                      onChanged: (value) {
                        _con!.releasingDate = value;

                      } ,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        suffixIcon:IconButton(onPressed: () async{
                          DateTime? dob = await DatePickerClass.selectDate(context,
                              firstDate:_con!.release_joinDate,
                              lastDate: DateTime(DateTime.now().year + 1));
                          if (dob != null) {
                            _con!.releasingDate =
                                DatePickerClass.dateFormatterMethod(dob);
                          }
                          setState(() {
                            _con!.expreleasingdate=false;
                          });
                        },icon: Icon(Icons.calendar_today),),
                        hintText: _con!.releasingDate == null
                            ? 'Releasing Date'
                            : _con!.releasingDate,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10),

                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kGreyColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),Row(
                children: [
                  Expanded(child: _con!.expjoindate?errorText("Joining Date is Required"):const SizedBox()),
                  Expanded(child: _con!.expreleasingdate?errorText("Releasing Date is Required"):const SizedBox())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 3,
                onChanged: (value){
                  _con!.description = value;
                  _con!.expdescription=false;
                } ,
                style: TextStyle(fontSize: 18),
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
              ),
              _con!.expdescription?errorText("Description is Required"):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              ReusableTextField(
                hintText: 'Designation',
                //key: Key('ed${_con!.designation}'),
                  controller: TextEditingController(text: _con!.designation),
               // initialValue: _con!.designation,
                onChanged: (value) {
                  _con!.designation=value;

                  _con!.expdesignation=false;
                  setState((){
                    _con!.expdesignation=false;
                  });
                }
              ),
              _con!.expdesignation?errorText("Designation is Required"):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   key: Key('es${_con!.salary}'),
              //   initialValue: _con!.salary.toString(),
              //   onChanged: (value) => _con!.salary = value ,
              //   style: TextStyle(fontSize: 18),
              //   decoration: InputDecoration(
              //     prefixText: '₹  ',
              //     prefixStyle:
              //         TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //     hintText: 'Offered Salary',
              //     contentPadding:
              //         EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: Center(
                  child: Row(
                    children: [
                      ReusableButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: 'Cancel',
                      ), SizedBox(
                        width: 20,
                      ),
                      ReusableButton(
                        onPressed: () {
                          setState(() { });
                          _con!.addExperienceLetter(context);
                        },
                        title: 'Save',
                      ),
                      SizedBox(width: 30,),

                    ],
                  ),
                ),
              ),

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
