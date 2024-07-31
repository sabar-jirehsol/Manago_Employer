import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/salary/employee_salary_details_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/salary_slip_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class EmployeeSalaryDetail extends StatefulWidget {
  final String? id;

  const EmployeeSalaryDetail({Key? key, this.id}) : super(key: key);
  @override
  _EmployeeSalaryDetailState createState() => _EmployeeSalaryDetailState();
}

class _EmployeeSalaryDetailState extends StateMVC<EmployeeSalaryDetail> {
  EmployeeSalaryslipController? _con;
  _EmployeeSalaryDetailState() : super(EmployeeSalaryslipController()) {
    _con = controller as EmployeeSalaryslipController?;
  }
  @override
  void initState() {
    super.initState();
    _con!.getSalaryAagainstEmployee(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: _con!.scaffoldKey,
        child: Scaffold(
          body: _con!.employeeSalaryList.length == 0
              ? Container(
                  child: Center(
                    child: Text(
                      'No Salary',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ListView.builder(
                      itemCount: _con!.employeeSalaryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalarySlipDetails(
                                  period: _con!.employeeSalaryList[index].salaryMonth!,
                                  netPay: _con!.employeeSalaryList[index].totalSalary!,
                                  earnings: _con!.employeeSalaryList[index].totalEarning!,
                                  deductions: _con!.employeeSalaryList[index].totalDeduction!,
                                  name: _con!.employeeSalaryList[index].employeeName!.split('(').first,
                                  designation: _con!.employeeSalaryList[index].employeeId!.designation!,
                                  joiningDate: _con!.employeeSalaryList[index].employeeId!.joiningDate!,
                                  basic: _con!.employeeSalaryList[index].earning!.basic.toString(),
                                  houseRentAllowance: _con!.employeeSalaryList[index].earning!.houseRentAllowance.toString(),
                                  conveyance: _con!.employeeSalaryList[index].earning!.conveyance.toString(),
                                  specialAllowance: _con!.employeeSalaryList[index].earning!.specialAllowance.toString(),
                                  mobileAllowance: _con!.employeeSalaryList[index].earning!.mobile.toString(),
                                  providentFund: _con!.employeeSalaryList[index].deductions!.providentFundDeduction.toString(),
                                  professionalTax: _con!.employeeSalaryList[index].deductions!.professionalTax.toString(),
                                  loan: _con!.employeeSalaryList[index].deductions!.loan.toString(),
                                ),
                              )),
                          child: Card(
                              color: Colors.grey.shade100,
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              // elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  leading: Container(
                                    width: 80,
                                    // height: 250,
                                    child: Text(
                                      _con!.employeeSalaryList[index].salaryMonth!,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   _con!.employeeSalaryList[index]
                                      //       .employeeName
                                      //       .split('(')
                                      //       .first,
                                      //   style: TextStyle(
                                      //       fontSize: 18,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Text(
                                      //   _con!.employeeSalaryList[index]
                                      //       .employeeName
                                      //       .split('(')
                                      //       .last
                                      //       .split(')')
                                      //       .first,
                                      //   style: TextStyle(
                                      //     color: Colors.red,
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(
                                        'Paid',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _con!.employeeSalaryList[index]
                                            .employeeId!.designation!,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   _con!.employerSalaryList[index].employeeId
                                      //       .id,
                                      //   style: TextStyle(
                                      //       fontSize: 14, color: Colors.red),
                                      // )
                                    ],
                                  ),
                                  trailing: Text(
                                    _con!.employeeSalaryList[index].totalSalary!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ),
        ));
  }
}
