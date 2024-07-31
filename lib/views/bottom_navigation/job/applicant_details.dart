import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/controllers/job/job_applicants_controller.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/resume.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/view_offer_letter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/ApplicationDetailProfileViewModel.dart';
import '../../../utils/success_dialogbox.dart';
import '../applicants/offer_details.dart';
import '../more/offer_letters/AddOfferLetter.dart';


class ApplicantDetails extends StatefulWidget {
  final ApplicantsDetailsData? data;
  final String? profile_id;

  const ApplicantDetails({Key? key, this.data,this.profile_id}) : super(key: key);
  @override
  _ApplicantDetailsState createState() => _ApplicantDetailsState();
}

class _ApplicantDetailsState extends StateMVC<ApplicantDetails> {
  JobApplicantsController? _con;

  _ApplicantDetailsState() : super(JobApplicantsController()) {
    _con = controller as JobApplicantsController?;
  }

 bool _isdownloading=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
 //  int progress=0;
 // ReceivePort receivePort=ReceivePort();
  @override
  void initState() {
    _con!.radiovalue = widget.data!.status;
    _con!.EmployerProfileCompletion(context);
    _con!.getApplicantsProfile(widget.profile_id!);
    // IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading Resume");
    // receivePort.listen((message){
    //   setState((){
    //     progress=message;
    //   });
    //
    // });
    // FlutterDownloader.registerCallback( downloadCallback);
    super.initState();

    _refreshIndicatorKey.currentState?.show();

  }
  static  downloadCallback(id,status,progress)async{
    SendPort? sendPort=IsolateNameServer.lookupPortByName('Downloading Resume');
    sendPort?.send(progress);
    print("PROGRESS $progress");
    print("Status ${status}");

    if (status == 3) {
      print("FILRRREEE OPENN");
      // Open the file automatically
      await FlutterDownloader.open(taskId: id);
    }



  }


  var userAge;


  @override
  Widget build(BuildContext context) {
    String dob = _con!.applicants_profileviewList?.personalInfo?.dob ?? "nodob";
    DateTime? dt1;
    String formattedDateString = "";

    if (dob != "nodob") {
      try {
        print("Dob from Api is ${dob}");
        dt1 = DateFormat("dd/MM/yyyy").parse(dob);
        print("Date of Birth is ${dt1}");
        formattedDateString = DateFormat("yyyy/MM/dd").format(dt1);
      } catch (e) {
        formattedDateString = "Invalid date format";
      }
    }

    DateTime? dt2;
    if (formattedDateString != "Invalid date format") {
      //dt2 = DateTime.tryParse(formattedDateString);
      dt2 = DateTime.tryParse(formattedDateString.replaceAll('/', '-'));
    }

    calAge(dt2!);

    // DateTime? dt1;
    // String dob = widget.data?.candidateId?.personalInfo?.dob ?? "nodob";
    // if (dob != "nodob") {
    //   dt1 = DateFormat("dd-MM-yyyy").parse(dob);
    // }
    //
    //
    // //DateTime dt1 = DateFormat("dd-MM-yyyy").parse(widget.data!.candidateId!.personalInfo!.dob!);
    //
    // //String formattedDateString = DateFormat("yyyy-MM-dd").format(dt1);
    // String formattedDateString = dt1 != null ? DateFormat("yyyy-MM-dd").format(dt1) : "";
    //  DateTime dt2 = DateTime.parse(formattedDateString);
    // calAge(dt2);
    // print("APPlicants details page JOB IDDs ${widget.data!.jobId!.id}");
    print("ID1 ${widget.data?.id}");
     print("ID2 ${_con!.applicants_profileviewList?.id}");
    print(_con!.applicants_profileviewList?.personalInfo?.dob);
    //print("APPLI Candidate Id ${widget.data!.candidateId!.id.toString()}");


    void _launchPDFDownloadURL(String url) async {
      //String url = '$baseUrl?userId=$userId';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    // void downloadfile(String url) async{
    //   print("Applicant Resumee");
    //   var time=DateTime.now().microsecondsSinceEpoch;
    //   var path="/storage/emulated/0/Download/Resume-$time.pdf";
    //   var file=File(path);
    //   var res=await get(Uri.parse(url));
    //   file.writeAsBytes(res.bodyBytes);
    // }

    return SafeArea(
      child: Scaffold(
          body: widget.data == null
              ? Container()
              : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
             await _con!.EmployerProfileCompletion(context);
              //await _con!.CheckIdwithOfferLetterList(widget.data!.id!);
              // Replace this delay with the code to be executed during refresh
              // and return a Future when code finishes execution.
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: ListView(
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
                    Transform.scale(
                      scale: 0.8,
                      child: RoundedReusableButton(
                        title: '${_con!.radiovalue ?? "-"}',
                        fillColor: kGreenColor.withOpacity(0.1),
                        borderColor: kGreenColor,
                        textColor: kGreenColor,
                        onPressed: ()  {
                          if (_con!.radiovalue != "Offer")
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.5,
                                  width: MediaQuery
                                      .of(context)
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
                                            fontWeight: FontWeight
                                                .bold),
                                      ),
                                      Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('Applied'),
                                              Radio(
                                                  activeColor:kPrimaryColor,
                                                  value: 'Applied',
                                                  groupValue:
                                                  _con!.radiovalue,
                                                  onChanged: (value) {
                                                    _con!
                                                        .updateStatus(
                                                      context,
                                                      widget.data!
                                                          .id!,
                                                      value!,
                                                      widget.data!
                                                          .candidateId!
                                                          .id!,
                                                      widget.data!
                                                          .candidateId!
                                                          .personalInfo!
                                                          .name!,
                                                    );
                                                  })
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('Shortlisted'),
                                              Radio(
                                                  value: 'Shortlisted',
                                                  activeColor:
                                                  kPrimaryColor,
                                                  groupValue:
                                                  _con!.radiovalue,
                                                  onChanged:
                                                      (value) async{
                                                        await showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Confirm Status Change'),
                                                            content: Text('Are you sure you want to  change the status?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(false); // User canceled delete
                                                                },
                                                                child: Text('Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async{
                                                                  Navigator.pop(context);
                                                                  _con!
                                                                      .updateStatus(
                                                                    context,
                                                                    widget.data!
                                                                        .id!,
                                                                    value!,
                                                                    widget.data!
                                                                        .candidateId!
                                                                        .id!,
                                                                    widget.data!
                                                                        .candidateId!
                                                                        .personalInfo!
                                                                        .name!,
                                                                  );

                                                                },
                                                                child: Text('Yes'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                        );

                                                  })
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('Selected'),
                                              Radio(
                                                  value: 'Selected',
                                                  activeColor:
                                                  kPrimaryColor,
                                                  groupValue:
                                                  _con!.radiovalue,
                                                  onChanged:
                                                      (value) async{
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Confirm Status Change'),
                                                          content: Text('Are you sure you want to  change the status?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop(false); // User canceled delete
                                                              },
                                                              child: Text('Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () async{
                                                                Navigator.pop(context);
                                                                _con!
                                                                    .updateStatus(
                                                                  context,
                                                                  widget.data!
                                                                      .id!,
                                                                  value!,
                                                                  widget.data!
                                                                      .candidateId!
                                                                      .id!,
                                                                  widget.data!
                                                                      .candidateId!
                                                                      .personalInfo!
                                                                      .name!,
                                                                );

                                                              },
                                                              child: Text('Yes'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                  })
                                            ],
                                          )),
                                      // Padding(
                                      //     padding:
                                      //         const EdgeInsets.symmetric(
                                      //             horizontal: 20),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment
                                      //               .spaceBetween,
                                      //       children: [
                                      //         Text('Offer'),
                                      //         Radio(
                                      //             value: 'Offer',
                                      //             groupValue:
                                      //                 _con!.radiovalue,
                                      //             activeColor:
                                      //                 kPrimaryColor,
                                      //             onChanged:
                                      //                 (value) {
                                      //               _con!.updateStatus(
                                      //                 context,
                                      //                 widget.data!.id!,
                                      //                 value!,
                                      //                 widget.data!
                                      //                     .candidateId!.id!,
                                      //                 widget.data!.candidateId!.personalInfo!.name!,
                                      //               );
                                      //             })
                                      //       ],
                                      //     )),
                                      // Padding(
                                      //     padding:
                                      //         const EdgeInsets.symmetric(
                                      //       horizontal: 20,
                                      //     ),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment
                                      //               .spaceBetween,
                                      //       children: [
                                      //         Text('Offer'),
                                      //         Radio(
                                      //             value: 'Offer',
                                      //             groupValue:
                                      //                 _con!.radiovalue,
                                      //             activeColor:
                                      //                 kPrimaryColor,
                                      //             onChanged: (value) {
                                      //               _con!.updateStatus(
                                      //                 context, widget.data!.id!, value!,
                                      //                 widget.data!.candidateId!.id!,
                                      //               );
                                      //             })
                                      //       ],
                                      //     )),
                                      Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('Rejected'),
                                              Radio(
                                                  value: 'Rejected',
                                                  activeColor:
                                                  kPrimaryColor,
                                                  groupValue:
                                                  _con!.radiovalue,
                                                  onChanged:
                                                      (value) async{
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text('Confirm Status Change'),
                                                          content: Text('Are you sure you want to  change the status?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop(false); // User canceled delete
                                                              },
                                                              child: Text('Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () async{
                                                                Navigator.pop(context);
                                                                _con!
                                                                    .updateStatus(
                                                                  context,
                                                                  widget.data!
                                                                      .id!,
                                                                  value!,
                                                                  widget.data!
                                                                      .candidateId!
                                                                      .id!,
                                                                  widget.data!
                                                                      .candidateId!
                                                                      .personalInfo!
                                                                      .name!,
                                                                );

                                                              },
                                                              child: Text('Yes'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                  })
                                            ],
                                          )),
                                    ],
                                  ),
                                );
                              },);


                        }),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CircleAvatar(
                    //   radius: 45,
                    //   backgroundImage: AssetImage('assets/images/logo.png'),
                    //   backgroundColor: Colors.white,
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70,
                      backgroundImage:  _con!.applicants_profileviewList?.personalInfo?.profilePic?.isEmpty??true?
                      // AssetImage('assets/images/logo.png') as ImageProvider<Object>:
                      AssetImage('assets/images/avatar.png') as ImageProvider<Object>:
                      NetworkImage(_con!.applicants_profileviewList!.personalInfo!.profilePic!),
                    ),
                    Text(
                      _con!.applicants_profileviewList!.personalInfo!.name!,
                      style: TextStyle(
                          fontSize: 22,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _con!.applicants_profileviewList!.jobPreference!.profileTitle
                          ?? '',
                      style: TextStyle(fontSize: 14, color: kBlueGrey),
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
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal:5),
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
                              subtitle: '${_con!.applicants_profileviewList!
                                  .professionalInfo!.totalExperience} years',
                            ),
                            SizedBox(height: 20),
                            _buildOverviewElement(
                              icon: 'assets/images/hourglass.png',
                              title: 'Age',

                              subtitle: '${userAge} years',
                            ),
                            SizedBox(height: 20),
                            _buildOverviewElement(
                              icon: 'assets/images/user.png',
                              title: 'Gender',
                              subtitle: '${_con!.applicants_profileviewList!
                                  .personalInfo!.gender} ',
                            ),
                            // SizedBox(height: 20),
                            // _buildOverviewElement(
                            //   icon: 'assets/images/location.png',
                            //   title: 'Location',
                            //   subtitle: '${widget.data!.candidateId!.jobPreference!.preferedLocation}',
                            // ),
                          ],
                        ),
                        SizedBox(width: 47),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildOverviewElement(
                              icon: 'assets/images/money.png',
                              title: 'Current Salary',
                              subtitle: ((_con!.applicants_profileviewList
                                  ?.professionalInfo?.jobDetails?.isNotEmpty ??
                                  false) &&
                                  (_con!.applicants_profileviewList?.professionalInfo
                                      ?.jobDetails?[0].salary != null ||
                                      _con!.applicants_profileviewList?.professionalInfo
                                          ?.jobDetails?[0].salary
                                          ?.toString()
                                          ?.isNotEmpty == true))
                                  ? '₹ ${_con!.applicants_profileviewList
                                  ?.professionalInfo?.jobDetails?[0].salary}.00'
                                  : "No salary",
                              //subtitle: '₹ ${widget.data!.candidateId?.professionalInfo?.jobDetails?[0].salary??'00'}.00'
                            ),
                            SizedBox(height: 20),
                            _buildOverviewElement(
                              icon: 'assets/images/dollar-sign.png',
                              title: 'Expected Salary',
                              // subtitle: ((widget.data!.candidateId
                              //     ?.professionalInfo?.jobDetails?.isNotEmpty ??
                              //     false) &&
                              //     (widget.data!.candidateId?.professionalInfo
                              //         ?.jobDetails?[0].salary != null ||
                              //         widget.data!.candidateId?.professionalInfo
                              //             ?.jobDetails?[0].salary
                              //             ?.toString()
                              //             ?.isNotEmpty == true))
                              //     ? '₹ ${widget.data!.candidateId
                              //     ?.professionalInfo?.jobDetails?[0].salary}.00'
                              //     : "No salary",
                              //subtitle: '₹ ${widget.data!.candidateId?.professionalInfo?.jobDetails?[0].salary??'00'}.00'
                              subtitle: '₹${widget.data!.exp_start_salary}000.00 - ${widget.data!.exp_end_salary}000.00',
                            ),
                            SizedBox(height: 20),
                            _buildOverviewElement(
                              icon: 'assets/images/graduation.png',
                              title: 'Education',
                              subtitle: '${_con!.applicants_profileviewList!
                                  .educationalInfo!.highestQualification ??
                                  '--'}',
                            ),
                          ],
                        )
                      ],
                    )

                  // GridView.count(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     // gridDelegate:
                  //     //     SliverGridDelegateWithFixedCrossAxisCount(
                  //     //         crossAxisCount: 2,
                  //     //         crossAxisSpacing: 1.0,
                  //     //         mainAxisSpacing: 1.0),

                  //     // itemCount: overviewTile.length,
                  //     // gridDelegate:
                  //     //     SliverGridDelegateWithFixedCrossAxisCount(
                  //     //         crossAxisCount: 2,
                  //     //         crossAxisSpacing: 1.0,
                  //     //         mainAxisSpacing: 1.0),
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 8.0,
                  //     mainAxisSpacing: 16,
                  //     children: List.generate(overviewTile.length, (index) {
                  //       return _buildOverviewElement(
                  //         icon: overviewTile[index].icon,
                  //         title: overviewTile[index].title,
                  //         subtitle: overviewTile[index].subtitle,
                  //       );
                  //     }

                  //         // itemBuilder: (BuildContext context, int index) {
                  //         //   return _buildOverviewElement(
                  //         //     icon: overviewTile[index].icon,
                  //         //     title: overviewTile[index].title,
                  //         //     subtitle: overviewTile[index].subtitle,
                  //         //   );
                  //         // },
                  //         )),
                ),
                SizedBox(height: 20),
                Text(
                  'Skills',
                  style: TextStyle(
                      fontSize: 22,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8.0, // set the spacing between chips
                  children: _con!.applicants_profileviewList!.professionalInfo!.keySkills!
                      .map((label) {
                    print("SKILLs");
                    print(_con!.applicants_profileviewList!.professionalInfo!.keySkills!);
                    return Chip(
                      label: Text(label),
                      backgroundColor: Color(0xffE8EBEE),
                      deleteButtonTooltipMessage: '',
                    );
                  }).toList(),
                ),
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
                      fontSize: 16,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  _con!.applicants_profileviewList!.personalInfo?.introduction ??
                      "Introduction Not yet given",

                  style: TextStyle(
                      fontSize: 14,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w400),
                ),
//                       Text(
//                         """
//                       Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
//
// Why do we use it?
// It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
//
//
// Where does it come from?
// Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
//
// The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
//
// Where can I get some?
// There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetion
//                       """,
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: kBlueGrey,
//                             fontWeight: FontWeight.w400),
//                       ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 30),
                  child: Text(
                    'Education',
                    style: TextStyle(
                        fontSize: 16,
                        color: kBlueGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                _con!.applicants_profileviewList!.educationalInfo!.educationDetails!
                    .length >
                    0
                    ? Column(
                  children:_con!.applicants_profileviewList!.educationalInfo!.educationDetails!.map((e) {
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
                _con!.applicants_profileviewList!.professionalInfo!.jobDetails!.length >
                    0
                    ? Container(
                  height: 155,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: _con!.applicants_profileviewList!.professionalInfo!
                        .jobDetails!.map((e) {
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
                            'tel:${_con!.applicants_profileviewList!.personalInfo!
                            .dialCode}${_con!.applicants_profileviewList!
                                .personalInfo!.mobile}');
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
                            '${_con!.applicants_profileviewList!.personalInfo!
                                .dialCode ?? ""} ${_con!.applicants_profileviewList!
                                .personalInfo!.mobile}',
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
                            'mailto:${_con!.applicants_profileviewList!.personalInfo!
                                .email}');
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
                          Text(
                            _con!.applicants_profileviewList!.personalInfo!.email ?? '',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                            //_launchPDFDownloadURL('http://apimanago2.v3red.com/candidate/downloadCandidateResume/${widget.data!.candidateId!.userId}');
                            downloadFile(
                                'http://apimanago2.v3red.com/candidate/downloadCandidateResume/${_con!.applicants_profileviewList!.userId}',  _con!.applicants_profileviewList!.personalInfo!.name!);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => ApplicantResume(
                            //               data: widget.data,
                            //             )));
                          },
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: kBlueGrey,
                          //Theme.of(context).copyWith().primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Offer Letter ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () async {
                            // await Navigator.push(context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             OfferDetails(
                            //               id: widget.data!.id!,
                            //               candidateId: widget.data!.candidateId!
                            //                   .id!,
                            //               name: widget.data!.candidateId!
                            //                   .personalInfo!.name!,
                            //               designation: widget.data!.jobId!
                            //                   .designation,
                            //             )));
                            print(widget.data!.id);
                            print("APPLICANT ID STATUS");

                              if(_con!.isprofilecompletion==true){
                            await Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => OfferDetails(
                                          id: widget.data!.id!,
                                          candidateId:  widget.data!.candidateId!.id!,
                                          name:widget.data!.candidateId!.personalInfo!.name!,
                                          designation:widget.data!.jobId!.designation,
                                        )));
                             await _con!.EmployerProfileCompletion(context);
                            _refreshIndicatorKey.currentState?.show();
                              }

                              else{
                                // EasyLoading.showToast('Offer Letter profile  Already Added.');
                                // Fluttertoast.showToast(msg:'Offer Letter profiel Already Added.',gravity: ToastGravity.CENTER, timeInSecForIosWeb: 7,backgroundColor: Colors.white,
                                //     textColor: kBlueGrey);
                           // Navigator.of(context).pop();
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
                            message:'Employer data incomplete. Please fill in your details in the profile section.' ,
                            onTap:(){

                            Navigator.pop(context);

                            }
                            );
                            },
                            ),
                            );

                            },
                            );


                             }

                          },
                        )),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          )),
    );
  }

  int calAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    userAge = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      userAge--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        userAge--;
      }
    }
    return userAge;
  }

  Column _buildEducationTile(EducationDetails e) {
    String? startyear = e.startDate?.substring(e.startDate!.length - 4);
    String? endyear = e.endDate?.substring(e.endDate!.length - 4);
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
        SizedBox(height: 10,),
      ],
    );
  }

  Widget _buildOverviewElement({@required String? icon,
    @required String? title,
    @required String? subtitle}) {
    return Container(
      //color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Image.asset(
              icon!,
              height: 16,
              width: 16,
            ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 16,
                    color: kBlueGrey,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle ?? '',
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

  Widget _buildJobTile(JobDetails e) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(right: 16, top: 5, bottom: 5, left: 5),
      width: 250,
      decoration: BoxDecoration(
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
                    fontSize: 15,
                    color: kBlueGrey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${e.employer}',
              style: TextStyle(
                  fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.startDate!,
                  //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.startDate!))}',
                  style: TextStyle(
                      fontSize: 12,
                      color: kBlueGrey,
                      fontWeight: FontWeight.w400),
                ),
                e.icurrentlyWorkHere=="true"||e.icurrentlyWorkHere=="Offer Letter"?
                Text(
                  'Currently working',
                  //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.endDate!))}',
                  style: TextStyle(
                      fontSize: 12,
                      color:Colors.green,
                      fontWeight: FontWeight.w400),
                ):  e.icurrentlyWorkHere=="false"||e.icurrentlyWorkHere=="Experience Letter"?
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
            SizedBox(height: 4),
            Text(
              '₹ ${e.salary.toString() + ".00  " + e.salaryType!}',
              //'${e.salary.toString() + " " }',
              style: TextStyle(
                  fontSize: 12, color: kBlueGrey, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 4),
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


  // void PDFDownloadURL(String url) async {
  //   print("Flutter Downloading the Applicants Resume");
  //   await FlutterDownloader.enqueue(
  //     url: url,
  //     headers: {},
  //     // optional: header send with url (auth token etc)
  //     savedDir: '/storage/emulated/0/Download',
  //     fileName: "Resume",
  //     showNotification: true,
  //     // show download progress in status bar (for Android)
  //     openFileFromNotification: true,
  //     // click on notification to open downloaded file (for Android)
  //     saveInPublicStorage: true,
  //   );
  // }

//   void PDFDownloadURL(String url,String name) async {
//     print("Applicant Resume download");
//     final mediastatus=await Permission.mediaLibrary.request();
//     final notificationstatus=await Permission.notification.request();
//     print(mediastatus);
//     print(notificationstatus);
//     if(mediastatus.isGranted && notificationstatus.isGranted){
//       final baseStorage=await getExternalStorageDirectory();
//       final id=await FlutterDownloader.enqueue(
//           url: url, savedDir:baseStorage!.path,
//           fileName: "${name}_Resume.pdf",
//         showNotification: true, // show download progress in status bar (for Android)
//         openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//
//       );
//
//  // // Listen for the download completion
// //       FlutterDownloader.registerCallback((id, status, progress) async {
// //         print("iddd$id");
// //         print("status$status");
// //         if (id == id || status == DownloadTaskStatus.complete) {
// //           // Show the dialog box when download is complete
// //           showDialog(
// //             context: context,
// //             builder: (context) => AlertDialog(
// //               title: Text('Download Complete'),
// //               content: Text('The file has been downloaded successfully.'),
// //               actions: [
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.of(context).pop();
// //                     OpenFile.open('${baseStorage.path}/${name}_Resume.pdf');
// //                   },
// //                   child: Text('Open File'),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }
// //       });
//
//     }
//     else{
//       print("NO permission");
//     }
//
//   }



}


