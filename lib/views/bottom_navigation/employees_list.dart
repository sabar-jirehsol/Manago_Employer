import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/controllers/employee/employee_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'employee_details/Employee_Search_Screen.dart';
import 'employee_details/employee_add/personal_info_view.dart';
import 'employee_details/employee_details_controller.dart';
import 'more/expereince_letter/view_experience_letter.dart';
import 'more/offer_letters/view_offer_letter.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({key, this.listType,this.listTitle}) : super(key: key);
  final EmployeeListType? listType;
  final  String? listTitle;

  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends StateMVC<EmployeesList> {
  EmployeeController? _con;
  bool showAddButton = false;


  _EmployeesListState() : super(EmployeeController()) {
    _con = controller as EmployeeController?;
  }
  @override  void initState() {
    super.initState();
    _con!.getEmployeeList(listType: widget.listType);
    bool showAddButton = widget.listType == EmployeeListType.ACTIVE;

    print(_con!.employeeList.length);
    print("LIst TYPE ${widget.listType.runtimeType}");

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
        title: Text(
          widget.listTitle!,
          //'Employees List',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: _con!.filteredEmployeeList.length == 0
          ? Container(
              child: Center(
                child: Text(
                  'No Employee Added',
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
              ),
            )
          : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45,
            
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(

                            width: showAddButton ? null : double.infinity,
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
                        ),
                        SizedBox(width: 20),
                        Visibility(
                          visible:showAddButton ,
                          child: GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => PersonalInfoScreen(),
                              ));
                              _con!.getDashboardCount(context);
                              _con!.getEmployeeList();


                            },
                            child: Container(
                              height: 32,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                              Row(children: [Icon(Icons.add), Text('Add')]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            
            
            
            
                //..............
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: _con!.filteredEmployeeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (widget.listType==EmployeeListType.ACTIVE){
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetailsController(
                                        id: _con!.filteredEmployeeList[index].id,
                                        profile_id:_con!.filteredEmployeeList[index].candidateId?.id ,
                                      ),
                                    ));
                                _con!.getDashboardCount(context);
                              } else if(widget.listType==EmployeeListType.OFFERED){
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetailsController(
                                        id: _con!.filteredEmployeeList[index].id,
                                        profile_id:_con!.filteredEmployeeList[index].candidateId?.id ,
                                      ),
                                    ));
                                // await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ViewOfferLetter(
                                //           id: _con!.filteredEmployeeList[index].id,
                                //         )));
                                _con!.getEmployeeList(listType: widget.listType);
                                _con!.getDashboardCount(context);
                              }
                              else if(widget.listType==EmployeeListType.RELIEVED){
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetailsController(
                                        id: _con!.filteredEmployeeList[index].id,
                                        profile_id:_con!.filteredEmployeeList[index].candidateId?.id ,
                                      ),
                                    ));
                              // await  Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => ViewExpereinceLetter(
                              //             id: _con!.filteredEmployeeList[index].id,
                              //           )));
                                _con!.getEmployeeList(listType: widget.listType);

                              }else{

                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmployeeDetailsController(
                                        id: _con!.filteredEmployeeList[index].id,
                                        profile_id:_con!.filteredEmployeeList[index].candidateId?.id ,
                                      ),
                                    ));
                                _con!.getDashboardCount(context);



                              }



                              _con!.getEmployeeList();
                              _con!.getDashboardCount(context);
                            },
                            child: Container(
                              // height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: kGreyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 7),
                              padding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            text: _con!
                                                        .filteredEmployeeList[index]
                                                        .candidateId!
                                                        .personalInfo!
                                                        .name ==
                                                    null
                                                ? 'Null'
                                                : _con!.filteredEmployeeList[index]
                                                    .candidateId!.personalInfo!.name,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(height: 4),
                                          // Wrap the designation text with Flexible

                                          Container(
                                            width: 200,
                                            child: Text(
                                              'Designation :  ${_con!.filteredEmployeeList[index].designation ?? '--'}',
                                            softWrap: false,
                                             maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                         // widget.listType==EmployeeListType.RELIEVED? const SizedBox.shrink():                                 //SizedBox(height:15):
                                          Text(
                                            _con!.filteredEmployeeList[index].offeredBasicSalary == "null"
                                             ? "Offered Salary :N/A"
                                             : 'Offered Salary : ₹ ${_con!.filteredEmployeeList[index].offeredBasicSalary}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          widget.listType==EmployeeListType.RELIEVED?

                                          Text(
                                            _con!.filteredEmployeeList[index].relivingDate == null
                                                ? "Relieving Date: --"
                                                : 'Relieving Date: ${DateFormat("dd/MM/yy").format(DateFormat("dd/MM/yyyy").parse(_con!.filteredEmployeeList[index].relivingDate!))}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ):widget.listType==EmployeeListType.ABSCONDED?  Text(
                                            _con!.filteredEmployeeList[index].abscondededDate == null
                                                ? "Absconded: --"
                                                : 'Absconded: ${DateFormat("dd/MM/yy").format(DateFormat("dd/MM/yyyy").parse(_con!.filteredEmployeeList[index].abscondededDate!))}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ):widget.listType==EmployeeListType.ACTIVE?  Text(
                                            _con!.filteredEmployeeList[index].workingDate == null||_con!.filteredEmployeeList[index].workingDate==""
                                                ? "Joining Date: --"
                                                : 'Joining Date: ${DateFormat("dd/MM/yy").format(DateFormat("dd/MM/yyyy").parse(_con!.filteredEmployeeList[index].workingDate!))}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ):
                                          Text(
                                            _con!.filteredEmployeeList[index].joiningDate == null
                                                ? "Offering Date: --"
                                                : 'Offering Date: ${DateFormat("dd/MM/yy").format(DateFormat("dd/MM/yyyy").parse(_con!.filteredEmployeeList[index].joiningDate!))}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),



                                          // Text(
                                          //
                                          //     _con!.filteredEmployeeList[index].joiningDate == null ? "Joining Date : --" :
                                          //     'Joining Date :
                                          //     ${DateFormat("dd-MM-yyyy").format(DateTime.parse(_con!.filteredEmployeeList[index].joiningDate!))}',
                                          //   style: TextStyle(
                                          //     fontSize: 14,
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          // ),
                                           SizedBox(height: 4),

                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: kBlueGrey,
                                                size: 18,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${_con!.filteredEmployeeList[index].candidateId!.personalInfo!.dialcode??""} ${_con!.filteredEmployeeList[index].candidateId!.personalInfo!.mobile}",
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.black,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: kGreenColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: kGreenColor.withOpacity(0.1),
                                                width: 1,
                                                style: BorderStyle.solid)),
                                        child: Text(
                                          'Full Time',
                                          style: TextStyle(
                                              fontSize: 12, color: kGreenColor),
                                        ),
                                      ),
                                      // SizedBox(height: 24),
                                      SizedBox(height: 60),
                                      SizedBox(
                                        width: 45,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: kPrimaryColor,
                                        ),
                                      )
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          );
                        }),
                  ),
              ],
            ),
          ),
    );
  }
}
