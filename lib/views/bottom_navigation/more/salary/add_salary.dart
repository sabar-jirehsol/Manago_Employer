import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/salarySlip_listtile.dart';
import 'package:manago_employer/controllers/salary/add_salary_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

import '../../../../components/searchable_dropDown.dart';

class AddSalary extends StatefulWidget {
  @override
  _AddSalaryState createState() => _AddSalaryState();
}

class _AddSalaryState extends StateMVC<AddSalary> {
  AddSalaryController? _con;
  _AddSalaryState() : super(AddSalaryController()) {
    _con = controller as AddSalaryController?;
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
      backgroundColor: Colors.white,
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
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Salary',
              style: TextStyle(color: kPrimaryColor),
            ),
            // IconButton(
            //   onPressed: () {
            //     // Add your delete action here
            //   },
            //   icon: Icon(
            //     Icons.delete,
            //     color: kRedColor,
            //   ),
            // ),
          ],
        ),
      ),

        body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),

              //EMployer
              // ReusableDropDown(
              //   hintText: 'Select Employee',
              //   // items: _con!.employeeNamesList.length == 0
              //   //     ? ['No data']
              //   //     : _con!.employeeNamesList,
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
                hintText: 'Select Employee',
                label: 'Select Employee',
                items: _con!.employeeNamesList,
                selectedItem: _con!.employee,
                showClearButton: false,
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    _con!.employee = value;
                    _con!.getEmployeeId(value);
                  });
                },
              ),

              SizedBox(
                height: 20,
              ),
              //Salary Date
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? dob = await DatePickerClass.selectDate(context,lastDate: DateTime.now());
                  if (dob != null) {
                    _con!.month = DatePickerClass.monthYear(dob);
                  }
                  setState(() {});
                },
                // onChanged: (value) => _con!.month = value,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: ()async{
                    DateTime? dob = await DatePickerClass.selectDate(context,lastDate:DateTime.now() );
                    if (dob != null) {
                      _con!.month = DatePickerClass.monthYear(dob);
                    }
                    setState(() {});

                  },icon: Icon(Icons.calendar_today),),
                  hintText: _con!.month == null ? 'Month' : _con!.month,
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
              SizedBox(
                height: 20,
              ),

              _con!.designation == null
                  ? Container()
                  : TextField(
                      readOnly: true,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: _con!.designation,
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
              //TODO: Basic salary
              // TextField(
              //   onChanged: (value) => _con!.basicSalary = value,
              //   style: TextStyle(fontSize: 18),
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     hintText: 'Basic Salary',
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
              TitleText(
                text: 'Earning(₹)',
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SalarySlipListtile(
                      title: 'Basic',
                      onChnaged: (value) => _con!.basic = value,
                    ),
                    SalarySlipListtile(
                      title: 'House Rent Allowance',
                      onChnaged: (value) => _con!.hounseRentAllowance = value,
                    ),
                    SalarySlipListtile(
                      title: 'Conveyance',
                      onChnaged: (value) => _con!.conveyance = value,
                    ),
                    SalarySlipListtile(
                      title: 'Special Allowance',
                      onChnaged: (value) => _con!.specialAllowance = value,
                    ),
                    SalarySlipListtile(
                      title: 'Mobile Allowance',
                      onChnaged: (value) => _con!.mobile = value,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TitleText(
                text: 'Deduction(₹)',
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SalarySlipListtile(
                      title: 'Provident Fund Deduction',
                      onChnaged: (value) => _con!.providentFunds = value,
                    ),
                    SalarySlipListtile(
                      title: 'Professional Tax',
                      onChnaged: (value) => _con!.professionalTax = value,
                    ),
                    SalarySlipListtile(
                      title: 'Loan & Advances',
                      onChnaged: (value) => _con!.loan = value,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Center(
                  child: Row(
                    children: [
                      ReusableButton(
                        title: 'Cancel',
                        onPressed: () {
                        Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 15,),
                      ReusableButton(
                        title: 'Save',
                        onPressed: () {

                          _con!.addSalary(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
