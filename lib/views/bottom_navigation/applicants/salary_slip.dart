import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/salary/salary_slip_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/salary_slip_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SalarySlip extends StatefulWidget {
  final String? id;

  const SalarySlip({Key? key,@required this.id}) : super(key: key);
  @override
  _SalarySlipState createState() => _SalarySlipState();
}

class _SalarySlipState extends StateMVC<SalarySlip> {
  SalarySlipController? _con;
  _SalarySlipState() : super(SalarySlipController()) {
    _con = controller as SalarySlipController?;
  }
  @override
  void initState() {
    super.initState();
    _con!.getSalarySlip(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Salary Slip'),
        ),
        body: _con!.salaryList.length == 0
            ? Container(
                child: Center(
                  child: Text('No salary slip.',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                      )),
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                  itemCount: _con!.salaryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalarySlipDetails(
                              period: _con!.salaryList[index].salaryMonth!,
                              netPay: _con!.salaryList[index].totalSalary!,
                              earnings: _con!.salaryList[index].totalEarning!,
                              deductions: _con!.salaryList[index].totalDeduction!,
                              name: _con!.salaryList[index].employeeName!
                                  .split('(')
                                  .first,

                              designation:
                                  _con!.salaryList[index].employeeId!.designation!,
                              joiningDate:
                                  _con!.salaryList[index].employeeId!.joiningDate!,
                              basic: _con!.salaryList[index].earning!.basic
                                  .toString(),
                              houseRentAllowance: _con!
                                  .salaryList[index].earning!.houseRentAllowance
                                  .toString(),
                              conveyance: _con!
                                  .salaryList[index].earning!.conveyance
                                  .toString(),
                              specialAllowance: _con!
                                  .salaryList[index].earning!.specialAllowance
                                  .toString(),
                              mobileAllowance: _con!
                                  .salaryList[index].earning!.mobile
                                  .toString(),
                              providentFund: _con!.salaryList[index].deductions!
                                  .providentFundDeduction
                                  .toString(),
                              professionalTax: _con!
                                  .salaryList[index].deductions!.professionalTax
                                  .toString(),
                              loan: _con!.salaryList[index].deductions!.loan
                                  .toString(),
                            ),
                          )),
                      child: Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              // height: 250,
                              child: Text(
                                _con!.salaryList[index].salaryMonth!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                            title: Transform.translate(
                              offset: Offset(-20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _con!.salaryList[index].employeeName!.split('(')
                                        .first,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _con!.salaryList[index].employeeId!.designation!,

                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  ),
                                  // Text(
                                  //   '#32145',
                                  //   style: TextStyle(
                                  //       fontSize: 14, color: Colors.red),
                                  // )
                                ],
                              ),
                            ),
                            trailing: Text(
                              '₹ ${_con!.salaryList[index].totalSalary}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          )),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
