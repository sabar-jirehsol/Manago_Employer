import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manago_employer/controllers/ProfileViewController.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/offer_details.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/add_expereince.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileView extends StatefulWidget {
  final String? candidateName;
  final String? highestQualification;
  final String? designation;
  final String? city;
  final String? email;
  final String? mobile;
  final String? id;
  final String? status;
  final bool? isEmployee;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? jobID;
  final String? candidateID;
  final String? employerID;
  final String? offeredBasicSalary;
  final String? offeredGrossSalary;
  final String? note;
  final String? joiningDate;
  final String? createdBy;
  final String? modifiedBy;

  const ProfileView(
      {Key? key,
      this.candidateName,
      this.highestQualification,
      this.designation,
      this.city,
      this.email,
      this.mobile,
      this.id,
      this.status,
      this.isEmployee,
      this.scaffoldKey,
      this.jobID,
      this.candidateID,
      this.employerID,
      this.offeredBasicSalary,
      this.offeredGrossSalary,
      this.note,
      this.joiningDate,
      this.createdBy,
      this.modifiedBy})
      : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends StateMVC<ProfileView> {
  ProfileViewController? _con;

  _ProfileViewState() : super(ProfileViewController()) {
    _con = controller as ProfileViewController?;
  }

  @override
  void initState() {
    super.initState();

    _con!.radiovalue = widget.status;
    _con!.scaffoldKey = widget.scaffoldKey!;
  }

  @override
  Widget build(BuildContext context) {
    bool isEmployee = widget.isEmployee ?? false;
    return //Profile info
        Container(
      color: kPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.candidateName!,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.highestQualification!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.designation ?? " ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(20)),
                      //   margin: EdgeInsets.symmetric(vertical: 5),
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      //   child: Text(
                      //     'ID: 123456',
                      //     style: TextStyle(color: Colors.white, fontSize: 12),
                      //   ),
                      // ),
                      // Container(
                      //   color: Colors.grey,
                      //   margin: EdgeInsets.symmetric(vertical: 5),
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 5),
                      //   child: Text(
                      //     '12 Oct 2018',
                      //     style:
                      //         TextStyle(color: Colors.black, fontSize: 12),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // city name
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.city!,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      //email
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.email!,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      //phone
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.call,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.mobile!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          widget.status == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () => isEmployee
                                      ? showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 150.0),
                                                      child: Divider(
                                                        thickness: 4.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Status',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Working'),
                                                            Radio(
                                                                activeColor: kPrimaryColor,
                                                                value: 'Working',
                                                                groupValue: _con!.radiovalue,
                                                                onChanged: (value) {
                                                                  _con!.updateEmployeeStatus(
                                                                    context, widget.id!, value!, widget.jobID!, widget.candidateID!,
                                                                    widget.employerID!, widget.offeredBasicSalary!,
                                                                    widget.offeredGrossSalary!, widget.designation!, widget.note!, widget.joiningDate!,
                                                                    widget.createdBy!, widget.modifiedBy!,
                                                                  );
                                                                  // setState(() {
                                                                  //   _con!.radiovalue = value;
                                                                  // });
                                                                  // Navigator.pop(context);
                                                                })
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Absconded'),
                                                            Radio(
                                                                activeColor: kPrimaryColor,
                                                                value: 'Absconded',
                                                                groupValue: _con!.radiovalue,
                                                                onChanged: (value) {
                                                                  _con!.updateEmployeeStatus(
                                                                    context, widget.id!, value!, widget.jobID!, widget.candidateID!, widget.employerID!,
                                                                    widget.offeredBasicSalary!, widget.offeredGrossSalary!, widget.designation!,
                                                                    widget.note!, widget.joiningDate!, widget.createdBy!, widget.modifiedBy!,
                                                                  );
                                                                })
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text('Relieved'),
                                                            Radio(
                                                                value: 'Relieved',
                                                                activeColor: kPrimaryColor,
                                                                groupValue: _con!.radiovalue,
                                                                onChanged: (value) {
                                                                  _con!.updateEmployeeStatus(
                                                                    context, widget.id!, value!, widget.jobID!,
                                                                    widget.candidateID!, widget.employerID!, widget.offeredBasicSalary!,
                                                                    widget.offeredGrossSalary!, widget.designation!, widget.note!, widget.joiningDate!,
                                                                    widget.createdBy!, widget.modifiedBy!,
                                                                  );
                                                                })
                                                          ],
                                                        )),
                                                  ],
                                                ));
                                          })
                                      : widget.status == "Offer"
                                          ? null
                                          : showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 150.0),
                                                        child: Divider(
                                                          thickness: 4.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text('Status',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Applied'),
                                                              Radio(
                                                                  activeColor: kPrimaryColor,
                                                                  value: 'Applied',
                                                                  groupValue: _con!.radiovalue,
                                                                  onChanged: (value) {
                                                                    _con!.updateStatus(
                                                                      context,
                                                                      widget.id!,
                                                                      value!,
                                                                      widget.candidateID!,
                                                                    );
                                                                    // setState(() {
                                                                    //   _con!.radiovalue = value;
                                                                    // });
                                                                    // Navigator.pop(context);
                                                                  })
                                                            ],
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Selected'),
                                                              Radio(
                                                                  value: 'Selected',
                                                                  activeColor: kPrimaryColor,
                                                                  groupValue: _con!.radiovalue,
                                                                  onChanged: (value) {
                                                                    _con!.updateStatus(
                                                                      context,
                                                                      widget.id!,
                                                                      value!,
                                                                      widget.candidateID!,
                                                                    );
                                                                    // setState(() {
                                                                    //   _con!.radiovalue = value;
                                                                    // });
                                                                    // Navigator.pop(context);
                                                                  })
                                                            ],
                                                          )),
                                                      // Padding(
                                                      //     padding:
                                                      //         const EdgeInsets
                                                      //                 .symmetric(
                                                      //             horizontal:
                                                      //                 20),
                                                      //     child: Row(
                                                      //       mainAxisAlignment:
                                                      //           MainAxisAlignment
                                                      //               .spaceBetween,
                                                      //       children: [
                                                      //         Text('Working'),
                                                      //         Radio(
                                                      //             value:
                                                      //                 'Working',
                                                      //             activeColor:
                                                      //                 kPrimaryColor,
                                                      //             groupValue: _con!
                                                      //                 .radiovalue,
                                                      //             onChanged:
                                                      //                 (String
                                                      //                     value) {
                                                      //               _con!.updateStatus(
                                                      //                 context,
                                                      //                 widget.id,
                                                      //                 value,
                                                      //                 widget
                                                      //                     .candidateID,
                                                      //               );
                                                      //               // setState(() {
                                                      //               //   _con!.radiovalue = value;
                                                      //               // });
                                                      //               // Navigator.pop(context);
                                                      //             })
                                                      //       ],
                                                      //     )),
                                                      Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Hold'),
                                                              Radio(
                                                                  value: 'Hold',
                                                                  groupValue: _con!.radiovalue,
                                                                  activeColor: kPrimaryColor,
                                                                  onChanged: (value) {
                                                                    _con!.updateStatus(
                                                                      context,
                                                                      widget.id!,
                                                                      value!,
                                                                      widget.candidateID!,
                                                                    );
                                                                  })
                                                            ],
                                                          )),
                                                      // Padding(
                                                      //     padding:
                                                      //         const EdgeInsets
                                                      //                 .symmetric(
                                                      //             horizontal:
                                                      //                 20),
                                                      //     child: Row(
                                                      //       mainAxisAlignment:
                                                      //           MainAxisAlignment
                                                      //               .spaceBetween,
                                                      //       children: [
                                                      //         Text('Cancel'),
                                                      //         Radio(
                                                      //             value:
                                                      //                 'Cancel',
                                                      //             groupValue: _con!
                                                      //                 .radiovalue,
                                                      //             activeColor:
                                                      //                 kPrimaryColor,
                                                      //             onChanged:
                                                      //                 (String
                                                      //                     value) {
                                                      //               _con!.updateStatus(
                                                      //                 context,
                                                      //                 widget.id,
                                                      //                 value,
                                                      //                 widget
                                                      //                     .candidateID,
                                                      //               );
                                                      //             })
                                                      //       ],
                                                      //     )),
                                                      Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20,),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Offer'),
                                                              Radio(
                                                                  value: 'Offer',
                                                                  groupValue: _con!.radiovalue,
                                                                  activeColor: kPrimaryColor,
                                                                  onChanged: (value) {
                                                                    _con!.updateStatus(
                                                                      context,
                                                                      widget.id!,
                                                                      value!,
                                                                      widget.candidateID!,
                                                                    );
                                                                    // Navigator.push(
                                                                    //     context,
                                                                    //     MaterialPageRoute(
                                                                    //         builder:
                                                                    //             (context) =>
                                                                    //                 OfferDetails()));
                                                                  })
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      _con!.radiovalue == null
                                          ? widget.status ?? 'Status'
                                          : _con!.radiovalue!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
