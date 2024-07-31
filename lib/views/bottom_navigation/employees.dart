import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:manago_employer/controllers/employee/employee_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/Employee_Search_Screen.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_details_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'employee_details/employee_add/personal_info_view.dart';
import 'employees_list.dart';


class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends StateMVC<Employees> {
  bool isSearching = false;
  EmployeeController? _con;
  _EmployeesState() : super(EmployeeController()) {
    _con = controller as EmployeeController?;
  }


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();

    _con!.getDashboardCount(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await   _con!.getDashboardCount(context);
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          print("Dashboard data calling");
          return Future<void>.delayed(const Duration(seconds: 1));
        },
        child: Scaffold(


          key: _con!.scaffoldKey,
          backgroundColor: Colors.white,
          body: _con!.dashbaordData == null //_con!.dashbaordData == null //Todo i added dummy datas to  the  dashboard values   counts
              ? Container(
                  child: Center(
                    child: Text(
                      'No Data Available',
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextField(
                                  readOnly: true,
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EmployeeSearchScreen(),
                                    ));
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.blueGrey,
                                    ),
                                    filled: true,
                                    fillColor: kPrimaryColor.withOpacity(0.2),
                                    hintText: 'Search by MobileNumber',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _con!.filteredEmployeeList = _con!
                                          .employeeList
                                          .where((element) => (element
                                                  .candidateId!.personalInfo!.name!
                                                  .toLowerCase()
                                                  .contains(value) ||
                                              element.designation!
                                                  .toLowerCase()
                                                  .toString()
                                                  .contains(value) ||
                                              element
                                                  .candidateId!.personalInfo!.mobile!
                                                  .contains(value)))
                                          .toList();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            //Todo i commented now 15-04-24 at 6:05 pm
                            // GestureDetector(
                            //   onTap: () async {
                            //     await Navigator.of(context)
                            //         .push(MaterialPageRoute(
                            //       builder: (context) => PersonalInfoScreen(),
                            //     ));
                            //     await _con!.getDashboardCount(context);
                            //     _refreshIndicatorKey.currentState?.show();
                            //     _con!.getEmployeeList();
                            //
                            //   },
                            //   child: Container(
                            //     height: 32,
                            //     padding: EdgeInsets.symmetric(horizontal: 8),
                            //     decoration: BoxDecoration(
                            //         color: kPrimaryColor.withOpacity(0.2),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child:
                            //         Row(children: [Icon(Icons.add), Text('Add')]),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeesList(
                                          listTitle:"Active Employees",
                                          listType: EmployeeListType.ACTIVE),
                                    ));
                                // _con!.getEmployeeList();
                                await _con!.getDashboardCount(context);
                                _refreshIndicatorKey.currentState?.show();
                              },
                              child: _buildEmployeeCountCard(

                                '${_con!.dashbaordData!.activeEmployees}',
                                'Active Employee',
                                'Updated on ${_con!.dashbaordData!.recent_active_date}',
                              ),

                            ),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeesList(
                                          listTitle:"Offered Employees",
                                          listType: EmployeeListType.OFFERED),
                                    ));
                                await _con!.getDashboardCount(context);
                                _refreshIndicatorKey.currentState?.show();
                                // _con!.getEmployeeList();
                              },
                              child: _buildEmployeeCountCard(

                                '${_con!.dashbaordData!.offeredEmployees}',
                                'Offered Employee',
                                'Updated on ${_con!.dashbaordData!.recent_offer_date}',
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeesList(
                                          listTitle:"Absconded Employees",
                                          listType: EmployeeListType.ABSCONDED),
                                    ));
                                await _con!.getDashboardCount(context);
                                _refreshIndicatorKey.currentState?.show();
                                // _con!.getEmployeeList();
                              },
                              child: _buildEmployeeCountCard(

                                '${_con!.dashbaordData!.abscondedEmployees}',
                                'Absconded Employee',
                                'Updated on ${_con!.dashbaordData!.recent_absconed_date}',
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeesList(
                                          listTitle:"Relieved Employees",
                                          listType: EmployeeListType.RELIEVED),
                                    ));
                                await _con!.getDashboardCount(context);
                                _refreshIndicatorKey.currentState?.show();
                                // _con!.getEmployeeList();
                              },
                              child: _buildEmployeeCountCard(

                                '${_con!.dashbaordData!.releivedEmployees ?? '-'}',
                                'Relieved Employee',
                                'Updated on ${_con!.dashbaordData!.recent_relive_date}',
                              ),
                            ),
                          ]),
                    ],
                  ),
                )),
        ),
      ),
    );
  }

  Widget _buildEmployeeCountCard(String count, String label, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.all(8),
      height: 250,
      decoration: BoxDecoration(
        color: Color(0xffF3F3FF),
        boxShadow: [
          BoxShadow(
            color: kGreyColor,
            blurRadius: 10.0,
          ),
        ],
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          count,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
        ),
        Text(
          label,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: kRedColor),
        )
      ]),
    );
  }
}
