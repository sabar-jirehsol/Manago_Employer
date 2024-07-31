import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/controllers/OfferLetterDetailsController.dart';
import 'package:manago_employer/controllers/applicants.dart/offer_letter_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Update_Experienceletter.dart';

class ViewExpereinceLetter extends StatefulWidget {
  final String? id;

  const ViewExpereinceLetter({Key? key, this.id}) : super(key: key);

  @override
  _ViewExpereinceLetterState createState() => _ViewExpereinceLetterState();
}

class _ViewExpereinceLetterState extends StateMVC<ViewExpereinceLetter> {
  OfferLetterDetailsController? _con;
  _ViewExpereinceLetterState() : super(OfferLetterDetailsController()) {
    _con = controller as OfferLetterDetailsController?;
  }



  void _launchPDFDownloadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _con!.offerLetterDetails(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            ''
                'Experience Letter',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateExperienceletter(
                          offerletterdetails: _con!.userData,
                        ),
                      ));
                  _con!.offerLetterDetails(widget.id!);
                },
                icon: Container(
                  color: kGreenColor.withOpacity(0.1),
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.edit,
                    color: kGreenColor,
                  ),
                )),
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
                            await   _con!.deleteOfferLetterandExp(widget.id!, context);
                            //

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
            //     onPressed: () {
            //       _con!.deleteOfferLetterandExp(widget.id!, context);
            //
            //       // print("DELETE ID ${_con!.jobDetails!.data!.id!}");
            //     },
            //     icon: Container(
            //       color: kRedColor.withOpacity(0.1),
            //       padding: EdgeInsets.all(2),
            //       child: Icon(
            //         Icons.delete,
            //         color: kRedColor,
            //       ),
            //     )),
          ],
        ),
        body: _con!.userData == null
            ? Container()
            : SingleChildScrollView(
              child: Container(

                  margin: EdgeInsets.only(left: 20,top: 20),
                  child:    Column(
                    children: [

                        //controller: _con!.screenshotController,
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Align(
                            //     alignment: AlignmentDirectional.topEnd,
                            //     child: Text(_con!.userData!.relivingDate!)),
                            Center(
                              child: Column(
                                children: [
                                  // Container(
                                  //   width: 50,
                                  //   height: 100,
                                  //   child: Image(
                                  //     image: AssetImage('assets/images/logo.png'),
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),

                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 70,
                                    backgroundImage:  _con?.userData?.employerId?.profilePic?.isEmpty??true?
                                    AssetImage('assets/images/logo.png') as ImageProvider<Object>:
                                    NetworkImage(_con!.userData!.employerId!.profilePic!),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      '${_con!
                                          .userData!.employerId!.businessName}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${_con!
                                        .userData!.employerId!.businessAddress??"company Address"}',
                                    //'Manago',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${_con!
                                        .userData!.employerId!.businessCity??"city"}  ${_con!
                                        .userData!.employerId!.businessState?.toLowerCase()??"state"} ',
                                        //'${_con!.userData!.employerId!.pincode??""} ',
                                    //'Manago',

                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     SizedBox(width: 1,),
                                  //     Text(
                                  //       '${_con!
                                  //           .userData!.employerId!.mobile}',
                                  //
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.w200),
                                  //     ),
                                  //
                                  //     Text(
                                  //       '${_con!
                                  //           .userData!.employerId!.email}',
                                  //
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.w200),
                                  //     ),
                                  //
                                  //   ],
                                  // )
                                ],
                              ),
                            ),

                            const Center(
                              child: Text(
                                "Experience Certificate",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height:5 ,),
                            Center(
                              child: Text(
                                'To whom it may concern',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: kPrimaryColor,
                                thickness: 1.0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                1.2),
                                    child: RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                            text: "This is to clarify that   ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Jost',
                                                color: kPrimaryColor),
                                            children: [
                                          TextSpan(
                                            text: _con!.userData!.candidateId!.personalInfo!.name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                //fontWeight: FontWeight.bold,
                                                color:kPrimaryColor),
                                          ),
                                          TextSpan(
                                              text: ",has served as a  ${_con!.userData!.designation} ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: kPrimaryColor)),
                                          // TextSpan(
                                          //   text: _con!.userData!.designation,
                                          //   style: TextStyle(
                                          //       fontSize: 14,
                                          //
                                          //       color: kPrimaryColor),
                                          // ),
                                              TextSpan(
                                                  text: "at ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),
                                              TextSpan(
                                                text: _con!
                                                    .userData!.employerId!.businessName,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    //fontWeight: FontWeight.bold,
                                                    color:kPrimaryColor),
                                              ),
                                          TextSpan(
                                              text: " from ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:kPrimaryColor)),
                                          TextSpan(
                                            text: _con!.userData!.joiningDate,
                                            style: TextStyle(
                                                fontSize: 14,
                                                //fontWeight: FontWeight.bold,
                                                color:kPrimaryColor),
                                          ),
                                          TextSpan(
                                              text: " to ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color:kPrimaryColor)),
                                          TextSpan(
                                            text:
                                                "${_con!.userData!.relivingDate}.\n",
                                            style: TextStyle(
                                                fontSize: 14,
                                                //fontWeight: FontWeight.bold,
                                                color: kPrimaryColor),
                                          ),
                                              TextSpan(
                                                  text: "During their tenure with us,",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),

                                              TextSpan(
                                                text:
                                                "${_con!.userData!.candidateId!.personalInfo!.name}.",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor),
                                              ),
                                              TextSpan(
                                                  text: "demonstrated professionalism, dedication, and proficiency in their role.\n",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),
                                              TextSpan(
                                                  text: "We confirm that ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),
                                              TextSpan(
                                                text:
                                                "${_con!.userData!.candidateId!.personalInfo!.name} \'s employment was released on ${_con!.userData!.relivingDate}.",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    //fontWeight: FontWeight.bold,

                                                    color:kPrimaryColor),
                                              ),
                                              // TextSpan(
                                              //     text: "\'s employment was released on ",
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         color:kPrimaryColor)),
                                              // TextSpan(
                                              //   text:
                                              //   "${_con!.userData!.relivingDate}.",
                                              //   style: TextStyle(
                                              //       fontSize: 14,
                                              //       //fontWeight: FontWeight.bold,
                                              //       color:kPrimaryColor),
                                              // ),
                                              TextSpan(
                                                  text: "in compliance with our company\'s policies and procedures. They have fulfilled all the necessary requirements and obligations associated with their role.\n",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),
                                              TextSpan(
                                                  text: "We wish ${_con!.userData!.candidateId!.personalInfo!.name}, all the best in their future endeavors.",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:kPrimaryColor)),

                                        ])),
                                  ),


                          SizedBox(height: 20,),
                                  Text(
                                    'Sincerely,',
                                    style: TextStyle(fontSize: 14,color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    //_con!.userData!.employerId!.name!,
                                    '${_con!
                                        .userData!.employerId!.businessName}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.bold),
                                      color: kPrimaryColor
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'HR',
                                    style: TextStyle(fontSize: 14,color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${_con!
                                        .userData!.employerId!.email}',
                                    style: TextStyle(fontSize: 14,color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          //     child: MaterialButton(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 20, vertical: 10),
                          //   color: kBlueGrey,//Theme.of(context).copyWith().primaryColor,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: Text(
                          //     'Download',
                          //     style: TextStyle(fontSize: 16, color: Colors.white),
                          //   ),
                          //   onPressed: () {
                          //     print(widget.id);
                          //     _launchPDFDownloadURL(
                          //         'http://apimanago2.v3red.com/document/downloadExpLetter/${widget.id}');
                          //
                          //    // _con!.getPdf();
                          //   },
                          // )),
                          Expanded(
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                color: kBlueGrey,//Theme.of(context).copyWith().primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                onPressed: () {
                                  print(widget.id);
                                Navigator.pop(context);

                                  // _con!.getPdf();
                                },
                              )),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color:kBlueGrey,//Theme.of(context).copyWith().primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            onPressed: () {
                                           _sharePdf(
                                               'http://apimanago2.v3red.com/document/downloadExpLetter/${widget.id}');
                              // _con!.sharePdf();
                               },


                          )),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
      ),
    );
  }


  Future<void> _sharePdf(String url) async {
    final offerLetterUrl = url;

    try {
      final bytes =
      await NetworkAssetBundle(Uri.parse(offerLetterUrl)).load('');

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/Experience_Letter.pdf');

      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      await Share.shareFiles([file.path], text: 'experience letter');
    } catch (e) {
      print('Error sharing experience letter: $e');
    }
  }
}
