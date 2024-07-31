import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/components/reusable_salary_details.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/edit_salary.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../controllers/salary/salary_slip_controller.dart';
import '../../../../utils/success_dialogbox.dart';
import 'package:http/http.dart' as http;

class SalarySlipDetails extends StatefulWidget {

  final String? period;
  final String? netPay;
  final String? earnings;
  final String? deductions;
  final String? name;
  final String? mobile;
  final String? dialcode;
  final String? designation;
  final String? joiningDate;
  final String? basic;
  final String? houseRentAllowance;
  final String? conveyance;
  final String? specialAllowance;
  final String? mobileAllowance;
  final String? providentFund;
  final String? professionalTax;
  final String? loan;
  final String? selectedEmployeeId;
  final String? selectedCandidateId;
  final String? salarySlipId;

  const SalarySlipDetails({
    Key? key,

    this.period,
    this.netPay,
    this.earnings,
    this.deductions,
    this.name,
    this.dialcode,
    this.mobile,
    this.designation,
    this.joiningDate,
    this.basic,
    this.houseRentAllowance,
    this.conveyance,
    this.specialAllowance,
    this.mobileAllowance,
    this.providentFund,
    this.professionalTax,
    this.loan,
    this.selectedEmployeeId,
    this.selectedCandidateId,
    this.salarySlipId,
  }) : super(key: key);



  @override
  _SalarySlipDetailsState createState() => _SalarySlipDetailsState();
}

class _SalarySlipDetailsState extends StateMVC<SalarySlipDetails> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SalarySlipController? _con;
  _SalarySlipDetailsState() : super(SalarySlipController()) {
    _con = controller as SalarySlipController?;
  }

  // void _launchPDFDownloadURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  int progress=0;
  ReceivePort receivePort=ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading Salaryslip");
    receivePort.listen((message){
      setState((){
        progress=message;
      });
    });
    FlutterDownloader.registerCallback( downloadCallback);
    super.initState();
  }
  static downloadCallback(id,status,progress){
    SendPort? sendPort=IsolateNameServer.lookupPortByName('Downloading Salaryslip');
    sendPort?.send(progress);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
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
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Salary Details',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => EditSalary(
                      month: widget.period,
                      employee: widget.name,
                      designation: widget.designation,
                      basic: widget.basic,
                      hounseRentAllowance: widget.houseRentAllowance,
                      conveyance: widget.conveyance,
                      specialAllowance: widget.specialAllowance,
                      dialcode:widget.dialcode,
                      mobile: widget.mobileAllowance,
                      providentFunds: widget.providentFund,
                      professionalTax: widget.professionalTax,
                      loan: widget.loan,
                      selectedEmployeeId: widget.selectedEmployeeId,
                      selectedCandidateId: widget.selectedCandidateId,
                      salarySlipId: widget.salarySlipId,
                    ),

                  ));

                  _con!.getSalaryAagainstEmployer();
                  setState(() {
                    widget.period;
                    widget.netPay;
                   widget. earnings;
                    widget.deductions;
                    widget.name;
                    widget.dialcode;
                    widget.mobile;
                    widget.designation;
                    widget.joiningDate;
                    widget.basic;
                    widget.houseRentAllowance;
                    widget.conveyance;
                    widget.specialAllowance;
                    widget.mobileAllowance;
                    widget.providentFund;
                    widget.professionalTax;
                    widget.loan;
                    widget.selectedEmployeeId;
                    widget.selectedCandidateId;
                    widget.salarySlipId;
                  });
                },
                icon: Container(
                  color: kGreenColor.withOpacity(0.1),
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.edit,
                    color: kGreenColor,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Delete'),
                      content: Text('Are you sure you want to delete?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // User canceled delete
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async{
                            await    _con!.deleteSalarySlip(widget.salarySlipId!, context);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Container(
                color: kRedColor.withOpacity(0.1),
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.delete,
                  color: kRedColor,
                ),
              ),
            )

            // IconButton(
            //     onPressed: (){
            //
            //
            //       print("SALARY SLIP ID -->DELETE ID ${widget.salarySlipId!}");
            //
            //
            //     },
            //     icon: Icon(
            //       Icons.delete,color: kRedColor,
            //     )
            // )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Period:',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 5),
                              Text(widget.period!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: kBlueColor,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          // Image(
                          //   image: AssetImage('assets/images/logo.png'),
                          //   width: 50,
                          //   height: 50,
                          // )
                        ],
                      ),
                    ),
                    // Employee details
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: kGreyColor),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlueGrey),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Designation: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlueGrey),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Contact No.: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlueGrey),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Joining Date: ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlueGrey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name!,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  widget.designation!,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '${widget.dialcode??''} ${widget.mobile!}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  widget.joiningDate!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Net pay
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: kBlueGrey),
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffAAA2A2).withOpacity(0.2)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //net pay
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Net Pay',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₹ ${widget.netPay}',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                              // earnings
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Earnings',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₹ ${widget.earnings}',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                              //deductions
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deductions',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₹ ${widget.deductions}',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //earnings
                    Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Earnings',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ReusableSalaryDetails(
                              title: 'Basic',
                              pay: widget.basic,
                            ),
                            ReusableSalaryDetails(
                              title: 'House Rent Allowance',
                              pay: widget.houseRentAllowance,
                            ),
                            ReusableSalaryDetails(
                              title: 'Conveyance',
                              pay: widget.conveyance,
                            ),
                            ReusableSalaryDetails(
                              title: 'Special Allowance',
                              pay: widget.specialAllowance,
                            ),
                            ReusableSalaryDetails(
                              title: 'Mobile Allowance',
                              pay: widget.mobileAllowance,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Deductions
                    Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deductions',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ReusableSalaryDetails(
                              title: 'Provident Fund Deduction',
                              pay: widget.providentFund,
                            ),
                            ReusableSalaryDetails(
                              title: 'Professional Tax',
                              pay: widget.professionalTax,
                            ),
                            ReusableSalaryDetails(
                              title: 'Loans & Advances',
                              pay: widget.loan,
                            ),
                          ],
                        ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color:kBlueGrey, //Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Share',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          _sharePdf(
                              'http://apimanago2.v3red.com/salary/downloadSalarySlip/${widget.salarySlipId}');
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: MaterialButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: kBlueGrey,//Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Download',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: () {
                          downloadFile(
                              'http://apimanago2.v3red.com/salary/downloadSalarySlip/${widget.salarySlipId}', widget.name!);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
                      message:'Salaryslip Downloaded successfully' ,
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

  // void PDFDownloadURL(String url,String name) async {
  //   final status=await Permission.mediaLibrary.request();
  //   if(status.isGranted){
  //     final baseStorage=await getExternalStorageDirectory();
  //     final id=await FlutterDownloader.enqueue(
  //       url: url, savedDir:baseStorage!.path,
  //       fileName: "${name}_Salaryslip.pdf",
  //       showNotification: true, // show download progress in status bar (for Android)
  //       openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  //     );
  //   }
  //   else{
  //     print("NO permission");
  //   }
  //
  // }

  Future<void> _sharePdf(String url) async {
    final offerLetterUrl = url;

    try {
      final bytes =
          await NetworkAssetBundle(Uri.parse(offerLetterUrl)).load('');

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/salary_slip.pdf');

      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      await Share.shareFiles([file.path], text: 'salary_slip');
    } catch (e) {
      print('Error sharing salary slip: $e');
    }
  }
}
