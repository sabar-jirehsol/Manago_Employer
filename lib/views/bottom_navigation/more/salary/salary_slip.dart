import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/salary/salary_slip_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/add_salary.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/salary_slip_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SalarySlip extends StatefulWidget {
  @override
  _SalarySlipState createState() => _SalarySlipState();
}

class _SalarySlipState extends StateMVC<SalarySlip> {
  SalarySlipController? _con;
  _SalarySlipState() : super(SalarySlipController()) {
    _con = controller as SalarySlipController?;
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _con!.getSalaryAagainstEmployer();



  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            'Salary Slip',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddSalary()));
                _con!.getSalaryAagainstEmployer();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(
                    Icons.add,
                    color: kBlueGrey,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(color: kBlueGrey),
                  )
                ]),
              ),
            )
          ],
        ),
        body: _con!.employerSalaryList.length == 0
            ? Container(
                child: Center(
                  child: Text(
                    'No Salary Slip Added',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                ),
              )
            : RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh:() async {
            await  _con!.getSalaryAagainstEmployer();
            // Replace this delay with the code to be executed during refresh
            // and return a Future when code finishes execution.
            return Future<void>.delayed(const Duration(seconds: 1));
          },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: _con!.employerSalaryList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return InkWell(
                          onTap: () async {

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SalarySlipDetails(

                                    period: _con!.employerSalaryList[index].salaryMonth!,
                                    netPay: _con!.employerSalaryList[index].totalSalary!,
                                    earnings: _con!.employerSalaryList[index].totalEarning!,
                                    deductions: _con!.employerSalaryList[index].totalDeduction!,
                                    name: _con!.employerSalaryList[index].employeeName!,
                                    dialcode:_con!.employerSalaryList[index].candidateId?.personalInfo!.dialcode,
                                    mobile:_con!.employerSalaryList[index].candidateId?.personalInfo!.mobile,
                                    designation: _con!.employerSalaryList[index].employeeId!.designation!,
                                    joiningDate: _con!.employerSalaryList[index].employeeId!.joiningDate!,
                                    basic: _con!.employerSalaryList[index].earning!.basic.toString(),
                                    houseRentAllowance: _con!.employerSalaryList[index].earning!.houseRentAllowance.toString(),
                                    conveyance: _con!.employerSalaryList[index].earning!.conveyance.toString(),
                                    specialAllowance: _con!.employerSalaryList[index].earning!.specialAllowance.toString(),
                                    mobileAllowance: _con!.employerSalaryList[index].earning!.mobile.toString(),
                                    providentFund: _con!.employerSalaryList[index].deductions!.providentFundDeduction.toString(),
                                    professionalTax: _con!.employerSalaryList[index].deductions!.professionalTax.toString(),
                                    loan: _con!.employerSalaryList[index].deductions!.loan.toString(),
                                    selectedEmployeeId: _con!.employerSalaryList[index].employeeId!.id!,
                                    selectedCandidateId: _con!.employerSalaryList[index].candidateId!.id,
                                    salarySlipId: _con!.employerSalaryList[index].id!,
                                  ),

                                ));
                           await  _con!.getSalaryAagainstEmployer();
                            _refreshIndicatorKey.currentState?.show();



                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: kBlueGrey),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/avatar.png',
                                      height: 50,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          text: _con!.employerSalaryList[index]
                                              .employeeName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        SizedBox(height: 3),
                                        Text(
                                          '${_con!.employerSalaryList[index].employeeId!.designation}',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                             '${_con!.employerSalaryList[index].candidateId?.personalInfo!.dialcode?? ''} ${_con!.employerSalaryList[index].candidateId?.personalInfo!.mobile}',
                                             // ' todo ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: kGreyColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                 // crossAxisAlignment: CrossAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xff1E3852)),
                                          color: const Color(0xff1E3852).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text(
                                          _con!.employerSalaryList[index].salaryMonth!,
                                          // _con!.salaryList.isEmpty
                                          //     ? '-'
                                          //     : _con!.salaryList[index].salaryMonth!,
                                          style: TextStyle(
                                              color: kBlueGrey, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:20),
                                    Text(
                                        "₹ "+_con!.employerSalaryList[index].totalSalary!+".00",
                                      // _con!.salaryList.isEmpty
                                      //     ? '-'
                                      //     : _con!.salaryList[index].totalSalary!,
                                      style: TextStyle(
                                          fontSize: 15, color: Color(0xff1F28CF),fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
            ),
      ),
    );
  }
}
