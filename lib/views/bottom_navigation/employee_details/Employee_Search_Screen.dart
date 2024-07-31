import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/controllers/Search_Candidate_Controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/CandidateDetails.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/personal_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_details_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EmployeeSearchScreen extends StatefulWidget {
  @override
  _SearchCandidateState createState() => _SearchCandidateState();
}

class _SearchCandidateState extends StateMVC<EmployeeSearchScreen> {
  SearchCandidateController? _con;
  _SearchCandidateState() : super(SearchCandidateController()) {
    _con = controller as SearchCandidateController?;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Search candidate',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [

                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly,
                       LengthLimitingTextInputFormatter(13),

                    ],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        hintText: 'Search by MobileNumber',
                        labelText: 'Search by MobileNumber.',
                        floatingLabelStyle: TextStyle(color:kBlueGrey),

                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {
                      if (value.length>=10 && value.length<=13) {
                        _con!.searchCandidate(context, value);
                        setState(() {});
                      } else {
                        EasyLoading.dismiss();
                        _con!.searchCandidateData = [];
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _con!.searchCandidateData == null ||
                        _con!.searchCandidateData.length == 0
                    ? Container(
                        child: Text(
                        "No Employee Added",
                        style: TextStyle(
                          fontSize: 18,
                          color: kPrimaryColor,
                        ),
                      ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _con!.searchCandidateData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CandidateDetails(
                                candidateData:
                                    _con!.searchCandidateData[index].id,
                              ),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,right:8.0),
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 50,
                                        height: 400,
                                        child: Text(
                                          DatePickerClass.dateFormatterMonths(_con!.searchCandidateData[index].createdAt!),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      title: RichText(
                                          text: TextSpan(
                                        text: _con!.searchCandidateData[index]
                                                    .personalInfo!.name ==
                                                null
                                            ? 'Null'
                                            : _con!.searchCandidateData[index]
                                                .personalInfo!.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _con!.searchCandidateData[index]
                                                    .personalInfo!.city ??
                                                "personal city ",
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            _con!
                                                        .searchCandidateData[
                                                            index]
                                                        .educationalInfo!
                                                        .highestQualification ==
                                                    null
                                                ? 'No Details'
                                                : _con!
                                                    .searchCandidateData[index]
                                                    .educationalInfo!
                                                    .highestQualification!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.green),
                                          ),
                                          // SizedBox(
                                          //   height: 3,
                                          // ),
                                          // Text(
                                          //   _con!.searchCandidateData[index]
                                          //       .designation,
                                          //   style: TextStyle(
                                          //     fontSize: 14,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      // trailing: Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   crossAxisAlignment: CrossAxisAlignment.end,
                                      //   children: [
                                      //     // Text(
                                      //     //   '#123456',
                                      //     //   style: TextStyle(
                                      //     //       color: Colors.red, fontSize: 12),
                                      //     // ),
                                      //     Text(
                                      //       _con!.applicantsList[index].status,
                                      //       style: TextStyle(
                                      //           color: Colors.red, fontSize: 12),
                                      //     ),
                                      //     Container(
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: 5, vertical: 3),
                                      //       decoration: BoxDecoration(
                                      //           borderRadius:
                                      //               BorderRadius.circular(10),
                                      //           color: kPrimaryColor),
                                      //       child: Text(
                                      //         'Resume',
                                      //         style: TextStyle(
                                      //             fontSize: 12,
                                      //             color: Colors.white),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
          ),
        ),
        // floatingActionButton: _con!.searchCandidateData == null ||
        //         _con!.searchCandidateData.length == 0
        //     ? FloatingActionButton.extended(
        //         backgroundColor: kBlueGrey,
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //             builder: (context) => PersonalInfoScreen(),
        //           ));
        //         },
        //         icon: Icon(Icons.add),
        //         label: Text('Add new Employee'),
        //       )
        //     : Container(),
      ),
    );
  }
}
