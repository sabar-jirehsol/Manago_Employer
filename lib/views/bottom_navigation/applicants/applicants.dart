import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/applicants.dart/applicants_controller.dart';
import 'package:manago_employer/provider/services.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/job/applicant_details.dart';
import 'package:provider/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'filter_applicants.dart';

class Applicants extends StatefulWidget {
  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends StateMVC<Applicants> {
  ApplicantsController? _con;
  _ApplicantsState() : super(ApplicantsController()) {
    _con = controller as ApplicantsController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getApplicantsAgainstEmployer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,

        backgroundColor: Color(0xf3f3ff),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _con!.applicantsList.length == 0
              ? Center(
            child: Text(
              'No Applicants',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black),
            ),
          )
              : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text(
                  //   'Applicants',
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       color: kBlueGrey,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 8),
                  //   child: GestureDetector(
                  //     onTap: () =>
                  //         Provider.of<Services>(context, listen: false)
                  //             .showJobapplicantTextfield(context),
                  //     child: Icon(
                  //       Icons.search,
                  //       color: kBlueGrey,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _openDialog,
                    child: Container(
                      height: 32,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        Icon(
                          Icons.flip_camera_android_rounded,
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Sort',
                          style: TextStyle(
                              fontSize: 14,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                            return FilterApplicants();
                          })).then((value) => setState(() {}));
                    },
                    child: Container(
                      height: 32,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        Icon(
                          Icons.filter_alt,
                          size: 14,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                              fontSize: 14,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.85,
                
                  // height: MediaQuery.of(context).size.height*0.65,
                  //height:650,
                
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemCount: _con!.applicantsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async{
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplicantDetails(
                                      data: _con!.applicantsList[index],
                                      profile_id:_con!.applicantsList[index].candidateId?.id,
                                    )));
                            await _con!.getApplicantsAgainstEmployer();
                          },
                          child: Container(
                            // height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                              text: _con!
                                                  .applicantsList[index]
                                                  .candidateId!
                                                  .personalInfo!
                                                  .name ==
                                                  null
                                                  ? 'Null'
                                                  : _con!
                                                  .applicantsList[index]
                                                  .candidateId!
                                                  .personalInfo!
                                                  .name!,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(height: 3),
                                        Container(
                                          width: 160, // Adjust this value according to your UI design
                                          child: Text(

                                            // _con!
                                            //       .applicantsList[index]
                                            //       .candidateId!
                                            //       .professionalInfo!
                                            //       .preferedFunction!,
                                            _con!
                                                .applicantsList[index]
                                                .candidateId!
                                                .jobPreference!.prefferedRole!??"",
                                            softWrap: false,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                         // Text(
                                         //   'Restaurant Manager / Restaurant Operation Manager',
                                         //   // _con!
                                         //   //     .applicantsList[index]
                                         //   //     .candidateId!
                                         //   //     .professionalInfo!
                                         //   //     .preferedFunction!,
                                         //
                                         //   softWrap: false,
                                         //   maxLines: 2,
                                         //   overflow: TextOverflow.ellipsis,
                                         //   style: TextStyle(
                                         //     fontSize: 12,
                                         //   ),
                                         // ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.access_time_filled,
                                              color: kBlueGrey,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(  DateTime.now().difference(_con!.applicantsList[index].createdAt!).inDays==0?"Applied Today":
                                              "Applied ${DateTime.now().difference(_con!.applicantsList[index].createdAt!).inDays} days ago",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              width: 120,
                                              child: Text(
                                               // 'applicants page-239',
                                                  ' ${_con!.applicantsList[index].candidateId?.personalInfo?.city ?? 'Unknown'}, ${_con!.applicantsList[index].candidateId?.personalInfo?.state ?? 'Unknown'}',

                                                  //  ' ${_con!.applicantsList[index].candidateId!.personalInfo!.city!}, ${_con!.applicantsList[index].candidateId!.personalInfo!.state!}',
                                               // ' ${_con!.applicantsList[index].jobId!.city![0]}, ${_con!.applicantsList[index].jobId!.state![0]}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width:70,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: kGreenColor.withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          border: Border.all(
                                              color: kGreenColor
                                                  .withOpacity(0.1),
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: Center(
                                        child: Text(
                                          ' ${_con!.applicantsList[index].status}',
                                          style: TextStyle(
                                              fontSize: 12, color: kGreenColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: kPrimaryColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sortList(bool _ascending) {
    setState(() {
      if (_ascending) {
        _con!.applicantsList.sort((a, b) => a.candidateId!.personalInfo!.name!
            .compareTo(b.candidateId!.personalInfo!.name!));
      } else {
        _con!.applicantsList.sort((a, b) => b.candidateId!.personalInfo!.name!
            .compareTo(a.candidateId!.personalInfo!.name!));
      }
    });
  }

  bool _ascending = true;

  void _openDialog() {
    showDialog(
        context: context,
        builder: (_) => SortDialog(
              sortVal: _ascending,
              sort: (val) {
                _ascending = val;
                _sortList(val);
                setState(() {});
              },
            ));
  }
}

class SortDialog extends StatefulWidget {
  const SortDialog({Key? key, this.sort, this.sortVal = true}) : super(key: key);
  final bool? sortVal;
  final Function? sort;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  bool _ascending = true;

  @override
  void initState() {
    _ascending = widget.sortVal!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sort by"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _ascending = !_ascending;
              });
            },
            title: Text("Ascending"),
            leading: Radio(
              value: true,
              activeColor: kBlueGrey,
              groupValue: _ascending,
              onChanged: (value) {
                setState(() {
                  _ascending = value!;
                });
              },
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _ascending = !_ascending;
              });
            },
            title: Text("Descending"),
            leading: Radio(
              activeColor: kBlueGrey,
              value: false,
              groupValue: _ascending,
              onChanged: (value) {
                setState(() {
                  _ascending = value!;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.sort!(_ascending);
            Navigator.of(context).pop();
          },
          child: Text("Sort"),
        ),
      ],
    );
  }
}
