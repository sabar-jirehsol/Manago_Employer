import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/controllers/resume_controller.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
//import 'package:screenshot/screenshot.dart';

import 'resume_widgets/education_details.dart';
import 'resume_widgets/paragraph.dart';
import 'resume_widgets/reusable_heading.dart';
import 'resume_widgets/reusable_profile_info.dart';
import 'resume_widgets/white_heading.dart';
import 'resume_widgets/workexperience_heading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantResume extends StatefulWidget {
  final ApplicantsDetailsData? data;

  const ApplicantResume({Key? key, this.data}) : super(key: key);
  @override
  _ApplicantResumeState createState() => _ApplicantResumeState();
}

class _ApplicantResumeState extends StateMVC<ApplicantResume> {
  ResumeController? _con;
  // String url = 'http://www.pdf995.com/samples/pdf.pdf';

  _ApplicantResumeState() : super(ResumeController()) {
    _con = controller as ResumeController?;
  }
  @override
  void initState() {
    super.initState();
    // _con.getCandidateDetails();
    _launchURL(); // Call _launchURL() method when the screen is initialized
  }
  _launchURL() async {
    const url = 'http://apimanago2.v3red.com/candidate/downloadCandidateResume/65d88ae1115e7aa6bd0d8583';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar: AppBar(
          title: Text('Resume'),
          actions: [],
        ),
        body:
          //controller: _con!.screenshotController,
          widget.data == null
              ? Container()
              :SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height,
                        color: Color.fromRGBO(13, 35, 67, 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableProfileInfo(
                              title: 'Phone',
                              value: widget
                                  .data!.candidateId!.personalInfo!.mobile!,
                            ),
                            ReusableProfileInfo(
                              title: 'Email',
                              value: widget
                                  .data!.candidateId!.personalInfo!.email!,
                            ),
                            ReusableProfileInfo(
                              title: 'Address',
                              value:
                              "${widget.data!.candidateId!.personalInfo!.address}, ${widget.data!.candidateId!.personalInfo!.city}, ${widget.data!.candidateId!.personalInfo!.state}",
                            ),
                            SizedBox(height: 20),
                            CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                AssetImage('assets/images/logo.png'),
                                backgroundColor: Colors.white),
                            SizedBox(height: 20),
                            widget.data!.candidateId!.educationalInfo!
                                .educationDetails!.length ==
                                0
                                ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Text(
                                'EDUCATION : ${widget.data!.candidateId!.educationalInfo!.highestQualification}',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            )
                                : Column(
                              children: [
                                ReusableHeading(
                                  title:
                                  'EDUCATION : ${widget.data!.candidateId!.educationalInfo!.highestQualification}',
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget
                                      .data!
                                      .candidateId!
                                      .educationalInfo!
                                      .educationDetails!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return EducationDetails(
                                      qualification: widget
                                          .data!
                                          .candidateId!
                                          .educationalInfo!
                                          .educationDetails![index]
                                          .qualification,
                                      year: widget
                                          .data!
                                          .candidateId!
                                          .educationalInfo!
                                          .educationDetails![index]
                                          .passingYear,
                                      study: widget
                                          .data!
                                          .candidateId!
                                          .educationalInfo!
                                          .educationDetails![index]
                                          .specialization,
                                      university: widget
                                          .data!
                                          .candidateId!
                                          .educationalInfo!
                                          .educationDetails![index]
                                          .university,
                                    );
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ReusableHeading(
                            //   title: 'ACHIEVEMENT',
                            // ),
                            // AchievementsDetail(
                            //   award: 'Award Name',
                            //   category: 'Category Award',
                            //   year: '2022',
                            //   placement: 'Placement',
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // AchievementsDetail(
                            //   award: 'Award Name',
                            //   category: 'Category Award',
                            //   year: '2022',
                            //   placement: 'Placement',
                            // )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      'Manago',
                                      style: TextStyle(fontSize: 8),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.data!.candidateId!.personalInfo!.name!,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromRGBO(13, 35, 67, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'WORK EXPERIENCE : ${widget.data!.candidateId!.professionalInfo!.totalExperience} yrs',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Divider(
                            //   color: Colors.purpleAccent,
                            //   thickness: 1,
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // WhiteHeading(
                            //   title: 'Introduction',
                            // ),
                            // Paragraph(
                            //   text: " ",
                            // ),
                            SizedBox(height: 10),
                            widget.data!.candidateId!.professionalInfo!
                                .jobDetails!.length ==
                                0
                                ? Container()
                                : Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                WhiteHeading(
                                  title: 'WORK EXPERIENCE',
                                ),
                                (widget.data!.candidateId!.professionalInfo!.totalExperience == 0 ||
                                    widget.data!.candidateId!.professionalInfo!.totalExperience == null)
                                    ? Container()
                                    : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget
                                      .data!.candidateId!
                                      .professionalInfo!
                                      .jobDetails!
                                      .length,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .start,
                                      children: [
                                        WorkexperienceHeading(
                                          title:
                                          '${widget.data!.candidateId!.professionalInfo!.jobDetails![index].jobTitle ?? " "} |${widget.data!.candidateId!.professionalInfo!.jobDetails![index].employer ?? " "} ',
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Paragraph(
                                          text: _con!.userData
                                              ?.professionalInfo ==
                                              null
                                              ? ' '
                                              : _con!
                                              .userData
                                              ?.professionalInfo
                                              ?.jobDetails![
                                          index].jobSummary,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            WhiteHeading(
                              title: 'Strength',
                            ),
                            widget.data!.candidateId!.jobPreference!
                                .strength ==
                                null
                                ? Container()
                                : ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.data!.candidateId!
                                  .jobPreference!.strength!
                                  .split(',')
                                  .toList()
                                  .length,
                              itemBuilder: (BuildContext context,
                                  int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 45),
                                  child: Text(
                                    widget.data!.candidateId!
                                        .jobPreference!.strength!
                                        .split(',')
                                        .toList()[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            WhiteHeading(
                              title: 'Weakness',
                            ),
                            widget.data!.candidateId!.jobPreference!.weakness == null
                                ? Container()
                                : ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.data!.candidateId!
                                  .jobPreference!.weakness!
                                  .split(',')
                                  .toList()
                                  .length,
                              itemBuilder: (BuildContext context,
                                  int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 45),
                                  child: Text(
                                    widget.data!.candidateId!
                                        .jobPreference!.weakness!
                                        .split(',')
                                        .toList()[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.orange,
                  thickness: 2,
                ),
                Center(
                  child: Text(
                    'Customer care or Helpline : +91 7791923586',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),


        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: '1',
                onPressed: () {
                  //_con!.getPdf();
                },
                backgroundColor: kPurple,
                child: Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: '2',
                onPressed: () {
                  //_con!.sharePdf();
                },
                backgroundColor: kPurple,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        //     FloatingActionButton(
        //         backgroundColor: kOrangeAccent,
        //         child: Icon(Icons.share_rounded),
        //         onPressed: () {
        //           final RenderBox box = context.findRenderObject();
        //           Share.share(
        //               'Please visit http://www.ideasailor.com to view resume',
        //               subject: 'Share Resume',
        //               sharePositionOrigin:
        //                   box.localToGlobal(Offset.zero) & box.size);
        //         })
        //   ],
        // ),
      ),
    );
  }
}

class EmployeeResume extends StatefulWidget {
  final EmployeeData? data;
  const EmployeeResume({Key? key, this.data}) : super(key: key);

  @override
  _EmployeeResumeState createState() => _EmployeeResumeState();
}

class _EmployeeResumeState extends StateMVC<EmployeeResume> {
  @override
  ResumeController? _con;
  // String url = 'http://www.pdf995.com/samples/pdf.pdf';

  _EmployeeResumeState() : super(ResumeController()) {
    _con = controller as ResumeController?;
  }
  @override
  void initState() {
    super.initState();
    // _con!.getCandidateDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar: AppBar(
          title: Text('Resume'),
          actions: [],
        ),
        body:
          //controller: _con!.screenshotController,
           widget.data == null
              ? Container()
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        // margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.height,
                              color: Color.fromRGBO(13, 35, 67, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableProfileInfo(
                                    title: 'Phone',
                                    value: widget
                                        .data!.candidateId!.personalInfo!.mobile,
                                  ),
                                  ReusableProfileInfo(
                                    title: 'Email',
                                    value: widget
                                        .data!.candidateId!.personalInfo!.email,
                                  ),
                                  ReusableProfileInfo(
                                    title: 'Address',
                                    value:
                                        "${widget.data!.candidateId!.personalInfo!.address}, ${widget.data!.candidateId!.personalInfo!.city}, ${widget.data!.candidateId!.personalInfo!.state}",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          AssetImage('assets/images/logo.png'),
                                      backgroundColor: Colors.white),
                                  widget.data!.candidateId!.educationalInfo!
                                                  .educationDetails!.length ==
                                              0 ||
                                          widget.data!.candidateId!
                                                  .educationalInfo ==
                                              null
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            'EDUCATION : ${widget.data!.candidateId!.educationalInfo!.highestQualification}',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            ReusableHeading(
                                              title: 'EDUCATION',
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: widget
                                                  .data!
                                                  .candidateId!
                                                  .educationalInfo!
                                                  .educationDetails!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return EducationDetails(
                                                  qualification:
                                                  widget
                                                      .data!
                                                      .candidateId!
                                                      .educationalInfo!
                                                      .educationDetails![index]
                                                      .qualification,
                                                  year: widget
                                                      .data!
                                                      .candidateId!
                                                      .educationalInfo!
                                                      .educationDetails![index]
                                                      .passingYear,
                                                  study: widget
                                                      .data!
                                                      .candidateId!
                                                      .educationalInfo!
                                                      .educationDetails![index]
                                                      .specialization,
                                                  university: widget
                                                      .data!
                                                      .candidateId!
                                                      .educationalInfo!
                                                      .educationDetails![index]
                                                      .university,
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // ReusableHeading(
                                  //   title: 'ACHIEVEMENT',
                                  // ),
                                  // AchievementsDetail(
                                  //   award: 'Award Name',
                                  //   category: 'Category Award',
                                  //   year: '2022',
                                  //   placement: 'Placement',
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // AchievementsDetail(
                                  //   award: 'Award Name',
                                  //   category: 'Category Award',
                                  //   year: '2022',
                                  //   placement: 'Placement',
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/logo.png',
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.contain,
                                          ),
                                          Text(
                                            'Manago',
                                            style: TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      widget.data!.candidateId!.personalInfo!.name!,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Color.fromRGBO(13, 35, 67, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      'WORK EXPERIENCE : ${widget.data!.candidateId!.professionalInfo!.totalExperience} yrs',
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Divider(
                                  //   color: Colors.purpleAccent,
                                  //   thickness: 1,
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // WhiteHeading(
                                  //   title: 'Introduction',
                                  // ),
                                  // Paragraph(
                                  //   text: " ",
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  widget.data!.candidateId!.professionalInfo!
                                              .jobDetails!.length ==
                                          0
                                      ? Container()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            WhiteHeading(
                                              title: 'WORK EXPERIENCE',
                                            ),
                                            (widget
                                                            .data!
                                                            .candidateId!
                                                            .professionalInfo!
                                                            .totalExperience ==
                                                        0 ||
                                                    widget
                                                            .data!
                                                            .candidateId!
                                                            .professionalInfo!
                                                            .totalExperience ==
                                                        null)
                                                ? Container()
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: widget
                                                        .data!
                                                        .candidateId!
                                                        .professionalInfo!
                                                        .jobDetails!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          WorkexperienceHeading(
                                                            title:
                                                                '${widget.data!.candidateId!.professionalInfo!.jobDetails![index].jobTitle ?? " "} |${widget.data!.candidateId!.professionalInfo!.jobDetails![index].employer ?? " "} ',
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Paragraph(
                                                            text: widget
                                                                .data!
                                                                .candidateId!
                                                                .professionalInfo!
                                                                .jobDetails![
                                                                    index]
                                                                .jobSummary,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                          ],
                                        ),

                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // WhiteHeading(
                                  //   title: 'Strength',
                                  // ),
                                  // widget.data.candidateId.jobPreference.strength == null
                                  //     ? Container()
                                  //     : ListView.builder(
                                  //         shrinkWrap: true,
                                  //         itemCount: _con!
                                  //             .userData.jobPreference.strength
                                  //             .split(',')
                                  //             .toList()
                                  //             .length,
                                  //         itemBuilder: (BuildContext context,
                                  //             int index) {
                                  //           return Container(
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal: 45),
                                  //             child: Text(
                                  //               widget
                                  //                   .data.jobPreference.strength
                                  //                   .split(',')
                                  //                   .toList()[index],
                                  //               style: TextStyle(
                                  //                 fontSize: 12,
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //       ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // WhiteHeading(
                                  //   title: 'Weakness',
                                  // ),
                                  // widget.data.candidateId.jobPreference.weakness == null
                                  //     ? Container()
                                  //     : ListView.builder(
                                  //         shrinkWrap: true,
                                  //         itemCount: _con!
                                  //             .userData.jobPreference.weakness
                                  //             .split(',')
                                  //             .toList()
                                  //             .length,
                                  //         itemBuilder: (BuildContext context,
                                  //             int index) {
                                  //           return Container(
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal: 45),
                                  //             child: Text(
                                  //               widget
                                  //                   .data.jobPreference.strength
                                  //                   .split(',')
                                  //                   .toList()[index],
                                  //               style: TextStyle(
                                  //                 fontSize: 12,
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //       ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.orange,
                        thickness: 2,
                      ),
                      Center(
                        child: Text(
                          'Customer care or Helpline : +91 7791923586',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),

        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: '1',
                onPressed: () {
                 // _con!.getPdf();
                },
                backgroundColor: kPurple,
                child: Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: '2',
                onPressed: () {
                  //_con!.sharePdf();
                },
                backgroundColor: kPurple,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        //     FloatingActionButton(
        //         backgroundColor: kOrangeAccent,
        //         child: Icon(Icons.share_rounded),
        //         onPressed: () {
        //           final RenderBox box = context.findRenderObject();
        //           Share.share(
        //               'Please visit http://www.ideasailor.com to view resume',
        //               subject: 'Share Resume',
        //               sharePositionOrigin:
        //                   box.localToGlobal(Offset.zero) & box.size);
        //         })
        //   ],
        // ),
      ),
    );
  }
}
