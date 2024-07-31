import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/salarySlip_listtile.dart';
import 'package:manago_employer/controllers/salary/edit_salary_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class EditSalary extends StatefulWidget {
  final String? month;
  final String? employee;
  final String? designation;
  final String? basic;
  final String? hounseRentAllowance;
  final String? conveyance;
  final String? specialAllowance;
  final String? dialcode;
  final String? mobile;
  final String? providentFunds;
  final String? professionalTax;
  final String? loan;
  final String? selectedEmployeeId;
  final String? selectedCandidateId;
  final String? salarySlipId;

  const EditSalary(
      {Key? key,
      this.month,
      this.employee,
      this.designation,
      this.basic,
      this.hounseRentAllowance,
      this.conveyance,
      this.specialAllowance,
        this.dialcode,
      this.mobile,
      this.providentFunds,
      this.professionalTax,
      this.loan,
      this.selectedEmployeeId,
      this.selectedCandidateId,
      this.salarySlipId})
      : super(key: key);
  @override
  _EditSalaryState createState() => _EditSalaryState();
}

class _EditSalaryState extends StateMVC<EditSalary> {
  EditSalaryController? _con;
  _EditSalaryState() : super(EditSalaryController()) {
    _con = controller as EditSalaryController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getEmployeeList();

    _con!.month = widget.month;
     _con!.employee = widget.employee;
     _con!.designation=widget.designation;
    _con!.selectedEmployeeId = widget.selectedEmployeeId;
    _con!.basic = widget.basic;
    _con!.hounseRentAllowance = widget.hounseRentAllowance;
    _con!.conveyance = widget.conveyance;
    _con!.specialAllowance = widget.specialAllowance;
    _con!.mobile = widget.mobile;
    _con!.providentFunds = widget.providentFunds;
    _con!.professionalTax = widget.professionalTax;
    _con!.loan = widget.loan;
    _con!.selectedCandidateId = widget.selectedCandidateId;
    _con!.selectedSalaryslipId = widget.salarySlipId;
    print("EDIT SALARY EMPLOYEE NAME IS ${_con!.employee}");
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
                )),
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Edit Salary',
              style: TextStyle(color: kPrimaryColor),
            ),
            // IconButton(
            //     onPressed: (){
            //
            //     },
            //     icon: Icon(
            //         Icons.delete,color: kRedColor,
            //     )
            // )
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
              //Salary Date
              TextFormField(
                initialValue: _con!.employee,
                readOnly: true,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: _con!.employee,
                  labelText: "EmployeeName",
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
              TextFormField(
                // initialValue: _con.month,
                readOnly: true,
                onTap: () async {
                  // DateTime? dob = await DatePickerClass.selectDate(context);
                  // if (dob != null) {
                  //   _con!.month = DatePickerClass.monthYear(dob);
                  // }
                  // setState(() {});
                },
                // onChanged: (value) => _con.month = value,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: _con!.month == null ? 'Salary Month' : _con!.month,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),

                  ),
                  suffixIcon:IconButton(icon:Icon(Icons.calendar_today) ,onPressed: () {  },),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),

                ),


              ),

               SizedBox(height: 20,),
              TextFormField(
                initialValue: _con!.designation,
                readOnly: true,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: _con!.designation,
                  labelText: "Designation",
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
              //EMployer

              // ReusableDropDown(
              //   hintText: "Select Employee",
              //   // items: _con.employeeNamesList.length == 0
              //   //     ? ['No data']
              //   //     : _con.employeeNamesList,
              //   options: ["Jigyasa Singh(7808388162)"],//_con!.employeeNamesList,
              //   onChanged: (value) {
              //     setState(() {
              //       _con!.employee = value;
              //       _con!.getEmployeeId(value);
              //     });
              //   },
              //   value: _con!.employee,
              // ),
              SizedBox(
                height: 20,
              ),

              // _con!.designation == null
              //     ? Container()
              //     : TextField(
              //         readOnly: true,
              //         style: TextStyle(fontSize: 18),
              //         decoration: InputDecoration(
              //           hintText: _con!.designation,
              //           contentPadding:
              //               EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //           enabledBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                 color: kPurple,
              //               ),
              //               borderRadius: BorderRadius.circular(10)),
              //           focusedBorder: OutlineInputBorder(
              //               borderSide: BorderSide(
              //                 color: kPurple,
              //               ),
              //               borderRadius: BorderRadius.circular(10)),
              //         ),
              //       ),
              SizedBox(
                height: 20,
              ),
              TitleText(
                text: 'Earning',
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SalarySlipListtile(
                      initialValue: _con!.basic,
                      title: 'Basic',
                      onChnaged: (value) => _con!.basic = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.hounseRentAllowance,
                      title: 'House Rent Allowance',
                      onChnaged: (value) => _con!.hounseRentAllowance = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.conveyance,
                      title: 'Conveyance',
                      onChnaged: (value) => _con!.conveyance = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.specialAllowance,
                      title: 'Special Allowance',
                      onChnaged: (value) => _con!.specialAllowance = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.mobile,
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
                text: 'Deduction',
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SalarySlipListtile(
                      initialValue: _con!.providentFunds,
                      title: 'Provident Fund Deduction',
                      onChnaged: (value) => _con!.providentFunds = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.professionalTax,
                      title: 'Professional Tax',
                      onChnaged: (value) => _con!.professionalTax = value,
                    ),
                    SalarySlipListtile(
                      initialValue: _con!.loan,
                      title: 'Loan',
                      onChnaged: (value) => _con!.loan = value,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Center(
                  child: Row(
                    children: [
                      ReusableButton(
                        title: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 30,),
                      ReusableButton(
                        title: 'Update',
                        onPressed: () {

                          print("UPdating salary details");
                          print(_con!.basic);
                          print(_con!.hounseRentAllowance);
                          _con!.updateSalary(context);
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
