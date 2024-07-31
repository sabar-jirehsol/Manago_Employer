import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/controllers/employee/employeeListDetailsController.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/education_info.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/job_preferrence.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/profession_info.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/profile_view.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/resume.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employer_info.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/salary_detail.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;

import '../../../models/ApplicationDetailProfileViewModel.dart';
import '../../../utils/success_dialogbox.dart';

class EmployeeDetailsController extends StatefulWidget {
  final String? id;
  final String? profile_id;

  const EmployeeDetailsController({Key? key, this.id,this.profile_id}) : super(key: key);
  @override
  _EmployeeDetailsControllerState createState() =>
      _EmployeeDetailsControllerState();
}

class _EmployeeDetailsControllerState extends StateMVC<EmployeeDetailsController> with SingleTickerProviderStateMixin {

  EmployeeListDetailsController? _con;
  _EmployeeDetailsControllerState() : super(EmployeeListDetailsController()) {
    _con = controller as EmployeeListDetailsController?;
  }

  TabController? tabController;

  final tabs = [EmployeeInfo(), EmployeeSalaryDetail()];

  // void _launchPDFDownloadURL(String url) async {
  //   //String url = '$baseUrl?userId=$userId';
  //   print("EMployee List${url}");
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  // void PDFDownloadURL(String url,String name) async {
  //   final status=await Permission.mediaLibrary.request();
  //   if(status.isGranted){
  //     final baseStorage=await getExternalStorageDirectory();
  //     final id=await FlutterDownloader.enqueue(
  //       url: url, savedDir:baseStorage!.path,
  //       fileName: "${name}_Resume.pdf",
  //       showNotification: true, // show download progress in status bar (for Android)
  //       openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  //     );
  //   }
  //   else{
  //     print("NO permission");
  //   }

  //}
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


  int progress=0;
  ReceivePort receivePort=ReceivePort();
  @override
  void initState() {
    print("employee profile id ${widget.profile_id!}");
    _con!.getApplicantsProfile(widget.profile_id!);
    // IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading Resume");
    // receivePort.listen((message){
    //   setState((){
    //     progress=message;
    //   });
    // });
    // FlutterDownloader.registerCallback( downloadCallback);
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    _con!.getEmployeeListDetails(widget.id!);

  }
  static downloadCallback(id,status,progress){
    SendPort? sendPort=IsolateNameServer.lookupPortByName('Downloadingresume');
    sendPort?.send(progress);
  }
  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  int? age;
  @override
  Widget build(BuildContext context) {
    if (_con!.applicants_profileviewList != null && _con!.applicants_profileviewList?.personalInfo != null) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime dob = dateFormat.parse(_con!.applicants_profileviewList!.personalInfo!.dob!);
      Duration difference = DateTime.now().difference(dob);
      age = (difference.inDays / 365).floor();
    }
    return SafeArea(
      child: Scaffold(
          body: _con!.applicants_profileviewList == null || _con!.applicants_profileviewList?.personalInfo == null
              ? Container(
                 // child: Center(child: Text('No Data Available')),
                )
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
                        // Transform.scale(
                        //   scale: 0.8,
                        //   child: RoundedReusableButton(
                        //     title: 'Active',
                        //     fillColor: kGreenColor.withOpacity(0.1),
                        //     borderColor: kGreenColor,
                        //     textColor: kGreenColor,
                        //     onPressed: () {},
                        //   ),
                        // ),
                        RoundedReusableButton(
                          title: '${_con!.employeeDetails!.status}',
                          fillColor: kGreenColor.withOpacity(0.1),
                          borderColor: kGreenColor,
                          textColor: kGreenColor,
                          onPressed: () {
                            if(_con!.employeeDetails!.status !="Relieved")
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                fontWeight: FontWeight.bold),
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
                                                  Text('Working'),
                                                  Radio(
                                                      activeColor:
                                                      kPrimaryColor,
                                                      value: 'Working',
                                                      groupValue:
                                                      _con!.radiovalue,
                                                      onChanged: (value) async{
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
                                                                  _con!.updateActivetoAbscondStatus(
                                                                    context,
                                                                    _con!.employeeDetails!.id!,
                                                                    value!,

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
                                                  Text('Absconded'),
                                                  Radio(
                                                      value: 'Absconded',
                                                      groupValue:
                                                      _con!.radiovalue,
                                                      activeColor:kPrimaryColor,
                                                      onChanged: (value) async{
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
                                                                    _con!.updateActivetoAbscondStatus(
                                                                      context,
                                                                      _con!.employeeDetails!.id!,
                                                                      value!,

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
                                  });


                          },
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
                    backgroundImage: _con!.applicants_profileviewList?.personalInfo?.profilePic!.toString().isEmpty??true?
                    // AssetImage('assets/images/logo.png') as ImageProvider<Object>:
                    AssetImage('assets/images/avatar.png') as ImageProvider<Object>:
                    NetworkImage(_con!.applicants_profileviewList!.personalInfo!.profilePic.toString()),
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
                          _con!.applicants_profileviewList!.jobPreference!.profileTitle??
                              '-',
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
                            EdgeInsets.symmetric(vertical: 24, horizontal: 10),
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
                                      '${_con!.applicants_profileviewList!.professionalInfo!.totalExperience} years',
                                ),
                                SizedBox(height: 30),
                                _buildOverviewElement(
                                  icon: 'assets/images/user.png',
                                  title: 'Date of Birth',
                                  subtitle:' ${_con!.applicants_profileviewList!.personalInfo?.dob ?? 'N/A'}',
                                ),
                                SizedBox(height: 30),
                                _buildOverviewElement(
                                  icon: 'assets/images/user.png',
                                  title: 'Gender',
                                  subtitle:
                                      '${_con!.applicants_profileviewList!.personalInfo!.gender}',
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
                                  //subtitle:'₹ ${_con?.employeeDetails?.jobId?.salary??"N/A"}.00',
                                  subtitle:((_con!.applicants_profileviewList?.professionalInfo?.jobDetails?.isNotEmpty ??false)&&(
                                      _con!.applicants_profileviewList?.professionalInfo?.jobDetails?[0].salary!=null||
                                          _con!.applicants_profileviewList?.professionalInfo?.jobDetails?[0].salary?.toString()==true))
                                  ?
                                  '₹ ${_con!.applicants_profileviewList?.professionalInfo?.jobDetails?[0].salary??"N/A"}.00':"No salary"
                                ),
                                SizedBox(height: 30),

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
                                      '${_con!.applicants_profileviewList!.educationalInfo!.highestQualification??"-"}',
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
                      children: _con!.applicants_profileviewList!
                          .professionalInfo!.keySkills!
                          .map((label) {
                        return Chip(
                          label: Text(label),
                          //useDeleteButtonTooltip: false,
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
                          fontSize: 14,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Text(_con!.applicants_profileviewList!.personalInfo!.introduction?? "Introduction Not yet  added",
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
                    _con!.applicants_profileviewList!.educationalInfo!
                                .educationDetails!.length >
                            0
                        ? Column(
                            children:_con!.applicants_profileviewList!
                                .educationalInfo!.educationDetails!
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
                    _con!.applicants_profileviewList!.professionalInfo!.jobDetails!
                                .length >
                            0
                        ? Container(
                            height: 145,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: _con!.applicants_profileviewList!
                                  .professionalInfo!.jobDetails!
                                  .map((e) {
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.phone,
                              color: kBlueGrey,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${_con!.applicants_profileviewList!.personalInfo!.dialCode??""} ${_con!.applicants_profileviewList!.personalInfo!.mobile!}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kBlueGrey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mail,
                              color: kBlueGrey,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              _con!.applicants_profileviewList!.personalInfo!
                                  .email!,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: kBlueGrey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Center(
                      child:  MaterialButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        color:kBlueGrey, //Theme.of(context).copyWith().primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Download CV',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          //_launchPDFDownloadURL('http://apimanago2.v3red.com/candidate/downloadCandidateResume/${ _con!.employeeDetails!.candidateId!.userId}');
                          downloadFile('http://apimanago2.v3red.com/candidate/downloadCandidateResume/${ _con!.employeeDetails!.candidateId!.userId}',_con!.employeeDetails!.candidateId!.personalInfo!.name!);

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => EmployeeResume(
                          //     data: _con!.employeeDetails,
                          //   ),
                          // ));
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
                    //       color:kBlueGrey, //Theme.of(context).copyWith().primaryColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Text(
                    //         'Download CV',
                    //         style: TextStyle(fontSize: 16, color: Colors.white),
                    //       ),
                    //       onPressed: () {
                    //         _launchPDFDownloadURL('http://apimanago2.v3red.com/candidate/downloadCandidateResume/${ _con!.employeeDetails!.candidateId!.userId}');
                    //         // Navigator.of(context).push(MaterialPageRoute(
                    //         //   builder: (context) => EmployeeResume(
                    //         //     data: _con!.employeeDetails,
                    //         //   ),
                    //         // ));
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
                    //         'Salary Slips',
                    //         style: TextStyle(fontSize: 16, color: Colors.white),
                    //       ),
                    //       onPressed: () {
                    //         Navigator.of(context).push(MaterialPageRoute(
                    //             builder: (context) => SafeArea(
                    //                   child: Scaffold(
                    //                     appBar:
                    //                         AppBar(title: Text('Salary Slips')),
                    //                     body: EmployeeSalaryDetail(
                    //                       id:widget.id!,
                    //                     ),
                    //                   ),
                    //                 )));
                    //       },
                    //     )),
                    //   ],
                    // ),
                    SizedBox(height: 50),
                  ],
                )),
    );
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
        SizedBox(height: 5),
        Text(
          "${e.university}",
          style: TextStyle(
              fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 5),
        Text(
          "${e.specialization}",
          style: TextStyle(
              fontSize: 13, color: kBlueGrey, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget _buildOverviewElement(
      {@required String? icon,
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

  Widget _buildJobTile(JobDetails e) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(right: 16,top: 5,bottom: 5,left: 5),
      width: 250,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Color(0xffE8EBEE),
                blurRadius: 2,spreadRadius: 2,
                offset: Offset(1,2)
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
                // Text(
                //   '${e.icurrentlyWorkHere=="true"?"Currently working":e.endDate}',
                //   //'${DateFormat("dd/MM/yyyy").format(DateTime.parse(e.endDate!))}',
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: kBlueGrey,
                //       fontWeight: FontWeight.w400),
                // ),
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

               '₹ ${e.salary!.toString()  + ".00 " + e.salaryType!}',
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
}

class OverviewTileModel {
  final Widget? icon;
  final String? title;
  final String? subtitle;

  OverviewTileModel({this.icon, this.title, this.subtitle});







}
