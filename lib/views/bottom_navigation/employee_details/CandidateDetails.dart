import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/controllers/candidate_details_controller.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
// import 'package:manago_employer/models/SearchhCandidateModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/resume.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import '../../../utils/success_dialogbox.dart';

class CandidateDetails extends StatefulWidget {
  final String? candidateData;

  const CandidateDetails({Key? key, this.candidateData}) : super(key: key);
  @override
  _CandidateDetailsState createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends StateMVC<CandidateDetails> with SingleTickerProviderStateMixin {
  CandidateDetailsController? _con;

  _CandidateDetailsState() : super(CandidateDetailsController()) {
    _con = controller as CandidateDetailsController?;
  }
  int progress=0;
  ReceivePort receivePort=ReceivePort();
  @override
  void initState() {

    print("DOB");
//print("Data of birth is ${_con!.userData!.personalInfo!.dob!}");

    _con!.getCandidateDetails(widget.candidateData!);
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading Resume");
    receivePort.listen((message){
      setState((){
        progress=message;
      });
    });
    FlutterDownloader.registerCallback( downloadCallback);

    super.initState();
  }
  static downloadCallback(id,status,progress){
    SendPort? sendPort=IsolateNameServer.lookupPortByName('Downloadingresume');
    sendPort?.send(progress);
  }
  // void _launchPDFDownloadURL(String url) async {
  //   //String url = '$baseUrl?userId=$userId';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    DateTime dob = dateFormat.parse(_con!.userData!.personalInfo!.dob??"00-00-0000");
    Duration difference = DateTime.now().difference(dob);
    int age = (difference.inDays / 365).floor();
    return SafeArea(
      child: Scaffold(
          body: _con!.userData == null
              ? Container(child: Text("No Data Available"),)
              : ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
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
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CircleAvatar( 'assets/images/avatar.png',
                  //   radius: 45,
                  //   backgroundImage: AssetImage('assets/images/logo.png'),
                  //   backgroundColor: Colors.white,
                  // ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 70,
                    backgroundImage:   _con!.userData?.personalInfo?.profilePic?.isEmpty??true?
                    // AssetImage('assets/images/logo.png') as ImageProvider<Object>:
                    AssetImage('assets/images/avatar.png') as ImageProvider<Object>:
                    NetworkImage(_con!.userData!.personalInfo!.profilePic!),
                  ),
                  Text(
                    _con!.userData!.personalInfo!.name!,
                    style: TextStyle(
                        fontSize: 22,
                        color: kBlueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _con!.userData!.jobPreference!.profileTitle
                        ?? "Preferred title",
                    //_con!.userData!.educationalInfo!.highestQualification!,
                    style: TextStyle(fontSize: 13, color: kBlueGrey),
                  ),
                ],
              ),
              SizedBox(height: 32),

              Text(
                'Overview',
                style: TextStyle(
                    fontSize: 22,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),

              Container(
                // height: 220,
                  padding:
                  EdgeInsets.symmetric(vertical: 24, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF3F3FF)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOverviewElement(
                            icon: 'assets/images/calendar.png',
                            title: 'Experience',
                            subtitle:
                            '${_con!.userData!.professionalInfo!
                                .totalExperience} years',
                          ),
                          SizedBox(height: 30),
                          _buildOverviewElement(
                            icon: 'assets/images/user.png',
                            title: 'Date of Birth',
                            subtitle: _con!.userData?.personalInfo?.dob??"dob",

                             ),

                          SizedBox(height: 30),
                          _buildOverviewElement(
                            icon: 'assets/images/user.png',
                            title: 'Gender',
                            subtitle:
                            '${_con!.userData!.personalInfo!.gender}',
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOverviewElement(
                            icon: 'assets/images/money.png',
                            title: 'Current Salary',
                            subtitle: ((_con?.userData?.professionalInfo
                                ?.jobDetails?.isNotEmpty ?? false) &&
                                (_con?.userData?.professionalInfo
                                    ?.jobDetails?[0]?.Salary != null ||
                                    _con?.userData?.professionalInfo
                                        ?.jobDetails?[0]?.Salary
                                        ?.toString()
                                        ?.isNotEmpty == true))
                                ? '₹ ${_con!.userData!.professionalInfo!
                                .jobDetails![0]!.Salary}.00'
                                : "No salary",

                            // subtitle:_con!.userData!.professionalInfo?.jobDetails?[0].Salary  !=null &&_con!.userData!.professionalInfo?.jobDetails![0].Salary?.toString().isNotEmpty==true
                            // &&_con!.userData!.professionalInfo?.jobDetails?[0].Salary  !=0
                            //     ? '₹ ${_con!.userData!.professionalInfo?.jobDetails?[0].Salary}.00'
                            //     :"No salary",
                          ),
                          SizedBox(height: 30),
                          // _buildOverviewElement(
                          //   icon: 'assets/images/dollar-sign.png',
                          //   title: 'Expected Salary',
                          //   subtitle: ((_con?.userData?.professionalInfo
                          //       ?.jobDetails?.isNotEmpty ?? false) &&
                          //       (_con?.userData?.professionalInfo
                          //           ?.jobDetails?[0]?.Salary != null ||
                          //           _con?.userData?.professionalInfo
                          //               ?.jobDetails?[0]?.Salary
                          //               ?.toString()
                          //               ?.isNotEmpty == true))
                          //       ? '₹ ${_con!.userData!.professionalInfo!
                          //       .jobDetails![0]!.Salary}.00'
                          //       : "No salary",
                          //   //  subtitle:_con!.userData!.professionalInfo?.jobDetails?[0].Salary!=null||_con!.userData!.professionalInfo?.jobDetails![0].Salary?.toString().isNotEmpty==true
                          //   // ?
                          //   //  '₹  ${_con!.userData!.professionalInfo?.jobDetails?[0].Salary}.00':"No salary",
                          //
                          // ),
                          _buildOverviewElement(
                            icon: 'assets/images/hourglass.png',
                            title: 'Age',

                            subtitle: '${age} years',
                          ),
                          SizedBox(height: 30),
                          _buildOverviewElement(
                            icon: 'assets/images/graduation.png',
                            title: 'Education',
                            subtitle:
                            '${_con!.userData!.educationalInfo!
                                .highestQualification ?? "-"}',
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(height: 20),
              Text(
                'Skills',
                style: TextStyle(
                    fontSize: 22,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              _con!.userData!.professionalInfo?.keySkills != "" ?
              Wrap(
                  spacing: 8.0, // set the spacing between chips
                  children:
                  _con!.userData!.professionalInfo!.keySkills!.map((label) {
                    return Chip(
                      label: label != null ? Text(label) : Text("-"),
                      //useDeleteButtonTooltip: false,
                    );
                  }).toList()
              ) : Text("-"),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                    fontSize: 22,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'About',
                style: TextStyle(
                    fontSize: 14,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w400),
              ),
              Text(_con!.userData!.personalInfo!.introduction ??
                  "Introduction not yet given ",
                style: TextStyle(
                    fontSize: 14,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w400),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 30),
                child: Text(
                  'Education',
                  style: TextStyle(
                      fontSize: 22,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
              _con!.userData!.educationalInfo!.educationDetails!.length > 0
                  ? Column(
                children: _con!.userData!.educationalInfo!.educationDetails!
                    .isEmpty ? [Text("No educational Details Availble")] : _con!
                    .userData!.educationalInfo!.educationDetails!
                    .map((e) {
                  return _buildEducationTile(e);
                }).toList(),
              )
                  : Text('-'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 30),
                child: Text(
                  'Work & Experience',
                  style: TextStyle(
                      fontSize: 22,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
              _con!.userData!.professionalInfo!.jobDetails!.length > 0
                  ? Container(
                height: 145,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _con!.userData!.professionalInfo!.jobDetails!.map((
                      e) {
                    return _buildJobTile(e);
                  }).toList(),
                ),
              )
                  : Text('-'),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 30),
                child: Text(
                  'Contact',
                  style: TextStyle(
                      fontSize: 22,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Uri phoneno = Uri.parse(
                          'tel:${_con!.userData!.personalInfo!.dialcode}${_con!
                              .userData!.personalInfo!.mobile}');
                      await launchUrl(phoneno);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone,
                          color: kBlueGrey,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${_con!.userData!.personalInfo!.dialcode ??
                              ""} ${_con!.userData!.personalInfo!.mobile}',
                          style: TextStyle(
                              fontSize: 14,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Uri mail = Uri.parse(
                          'mailto:${_con!.userData!.personalInfo!.email}');
                      await launchUrl(mail);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.mail,
                          color: kBlueGrey,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(_con!.userData!.personalInfo!.email!,
                          style: TextStyle(
                              fontSize: 14,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Center(
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  color: kBlueGrey,
                  //Theme.of(context).copyWith().primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Download CV',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    // _launchPDFDownloadURL(
                    //     'http://apimanago2.v3red.com/candidate/downloadCandidateResume/${_con!
                    //         .userData!.userId}');
                    downloadFile(
                        'http://apimanago2.v3red.com/candidate/downloadCandidateResume/${_con!
                            .userData!.userId}',  _con!.userData!.personalInfo!.name!);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => ApplicantResume(
                    //               data: _con.userData,
                    //             )));
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //         child: MaterialButton(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       color: kBlueGrey,//Theme.of(context).copyWith().primaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Text(
              //         'Download CV',
              //         style: TextStyle(fontSize: 16, color: Colors.white),
              //       ),
              //       onPressed: () {
              //         _launchPDFDownloadURL('http://apimanago2.v3red.com/candidate/downloadCandidateResume/${_con!.userData!.userId}');
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (_) => ApplicantResume(
              //         //               data: _con.userData,
              //         //             )));
              //       },
              //     )),
              //     SizedBox(
              //       width: 16,
              //     ),
              //     Expanded(
              //         child: MaterialButton(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       color: kBlueGrey,//Theme.of(context).copyWith().primaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: Text(
              //         'Offer Letter',
              //         style: TextStyle(fontSize: 16, color: Colors.white),
              //       ),
              //       onPressed: () {
              //
              //
              //       },
              //     )),
              //   ],
              // ),
              SizedBox(height: 50),
            ],
          )),
    );
  }

  Column _buildEducationTile(EducationDetail e) {
    String? startyear = e.startDate != null && e.startDate!.length >= 4
        ? e.startDate!.substring(e.startDate!.length - 4)
        : "No Startdate";

    String? endyear = e.endDate != null && e.endDate!.length >= 4
        ? e.endDate!.substring(e.endDate!.length - 4)
        : "No enddate";


    // String? startyear = e.startDate?.substring(e.startDate!.length - 4)??"No Startdate";
    // String? endyear = e.endDate?.substring(e.endDate!.length - 4)?? "No enddate";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${e.educationType}",
              // "${e.qualification}",
              style: TextStyle(
                  fontSize: 16, color: kBlueGrey, fontWeight: FontWeight.w500),
            ),
            Text(
              "${startyear} - ${endyear}",
              // "${e.startDate} - ${e.endDate}",
              // "${e.passingYear}",
              style: TextStyle(
                  fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "${e.university}",
          style: TextStyle(
              fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10),
        Text(
          "${e.specialization}",
          style: TextStyle(
              fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildOverviewElement({@required String? icon,
    @required String? title,
    @required String? subtitle}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon!,
            height: 16,
            width: 16,
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 16,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle!,
                style: TextStyle(
                    fontSize: 13,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildJobTile(JobDetail e) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(right: 16, top: 5, bottom: 5, left: 5),
      width: 250,
      decoration: BoxDecoration(
        //color: Color(0xffE8EBEE),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Color(0xffE8EBEE),
                blurRadius: 2, spreadRadius: 2,
                offset: Offset(1, 2)
            )
          ]

      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${e.jobTitle}',
                style: TextStyle(
                    fontSize: 14,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${e.employer}',
              style: TextStyle(
                  fontSize: 12, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${e.startDate}',
                  style: TextStyle(
                      fontSize: 12,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w400),
                ),
                // Text(
                //   '${e.currentlyWorkHere=="true"?"Currently working":e.endDate}',
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: kBlueGrey,
                //       fontWeight: FontWeight.w400),
                // ),
               e.currentlyWorkHere=="true"||e.currentlyWorkHere=="Offer Letter"?
                Text(
                  'Currently working',
                  //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.endDate!))}',
                  style: TextStyle(
                      fontSize: 12,
                      color:Colors.green,
                      fontWeight: FontWeight.w400),
                ):  e.currentlyWorkHere=="false"||e.currentlyWorkHere=="Experience Letter"?
                Text(
                  e.endDate!,
                  //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.endDate!))}',
                  style: TextStyle(
                      fontSize: 12,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w400),
                ):  Text(
                  "Absconded",
                  //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.endDate!))}',
                  style: TextStyle(
                      fontSize: 12,
                      color:Colors.red,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(

              '₹ ${e.Salary.toString() + '.00  ' +(e.salaryType == null ? "" : e.salaryType!)} ',
              style: TextStyle(
                  fontSize: 12, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              '${e.city}',
              style: TextStyle(
                  fontSize: 12, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
          ]),
    );
  }
  void downloadFile(String url,String name) async {
    try {
      print("Downloading applicant resume...");
      var time = DateTime
          .now()
          .microsecondsSinceEpoch;
      Directory? directory;

      if (Platform.isAndroid) {
        directory =  await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      // if (!await directory.path!.exists()) {
      //   await directory.create(recursive: true);
      // }

      var path = "${directory?.path}/${name}_Resume.pdf";
      var file = File(path);
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context){
            return WillPopScope(
              onWillPop: () async => false,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return   FunkyOverlay(
                      imagePath: 'assets/images/tick.png',
                      message:'Resume Downloaded successfully' ,
                      onTap:()async{
                        print(path);
                        Navigator.pop(context);
                        await OpenFile.open(path);

                      }
                  );
                },
              ),
            );
          },
        );
        print("File downloaded successfully: $path");
      } else {
        print("Failed to download file. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  // void downloadFile(String url) async {
  //   try {
  //     print("Downloading applicant resume...");
  //     var time = DateTime
  //         .now()
  //         .microsecondsSinceEpoch;
  //     Directory? directory;
  //
  //     if (Platform.isAndroid) {
  //       directory = Directory('/storage/emulated/0/Download');
  //     } else {
  //       directory = await getApplicationDocumentsDirectory();
  //     }
  //
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //
  //     var path = "${directory.path}/Resume-$time.pdf";
  //     var file = File(path);
  //     var response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       await file.writeAsBytes(response.bodyBytes);
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (context) {
  //           return WillPopScope(
  //             onWillPop: () async => false,
  //             child: StatefulBuilder(
  //               builder: (context, setState) {
  //                 return FunkyOverlay(
  //                     imagePath: 'assets/images/tick.png',
  //                     message: 'Resume Downloaded successfully',
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     }
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //       );
  //       print("File downloaded successfully: $path");
  //     } else {
  //       print("Failed to download file. Status code: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error downloading file: $e");
  //   }
  // }
  void PDFDownloadURL(String url,String name) async {
    final status=await Permission.mediaLibrary.request();
    if(status.isGranted){
      final baseStorage=await getExternalStorageDirectory();
      final id=await FlutterDownloader.enqueue(
        url: url, savedDir:baseStorage!.path,
        fileName: "${name}_Resume.pdf",
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
    }
    else{
      print("NO permission");
    }

  }

}
