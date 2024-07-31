
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/controllers/OfferLetterDetailsController.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/rounded_reusable_button.dart';
import 'Update_offerletter.dart';

class ViewOfferLetter extends StatefulWidget {
  final String? id;

  const ViewOfferLetter({Key? key, this.id}) : super(key: key);

  @override
  _ViewOfferLetterState createState() => _ViewOfferLetterState();
}

class _ViewOfferLetterState extends StateMVC<ViewOfferLetter> {
  OfferLetterDetailsController? _con;

  _ViewOfferLetterState() : super(OfferLetterDetailsController()) {
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
            'Offer Letter',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [ Transform.scale(
          scale: 0.8,
          child: RoundedReusableButton(
            title: '${_con!.radiovalue}',
            fillColor: kGreenColor.withOpacity(0.1),
            borderColor: kGreenColor,
            textColor: kGreenColor,
            onPressed: () {
              // showModalBottomSheet(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(20),
              //             topRight: Radius.circular(20))),
              //     context: context,
              //     builder: (context) {
              //       return Container(
              //         height:
              //         MediaQuery.of(context).size.height *
              //             0.5,
              //         width: MediaQuery.of(context).size.width,
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 150.0),
              //               child: Divider(
              //                 thickness: 4.0,
              //                 color: Colors.black,
              //               ),
              //             ),
              //             Text(
              //               'Status',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             Padding(
              //                 padding:
              //                 const EdgeInsets.symmetric(
              //                     horizontal: 20),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                   MainAxisAlignment
              //                       .spaceBetween,
              //                   children: [
              //                     Text('Offered'),
              //                     Radio(
              //                         activeColor:
              //                         kPrimaryColor,
              //                         value: 'Offered',
              //                         groupValue:
              //                         _con!.radiovalue,
              //                         onChanged: (value) {
              //                           _con!.updateOfferLetterStatus(
              //                             context,
              //                             _con!.userData!.employeeId!,
              //                             value!,
              //
              //                           );
              //                         })
              //                   ],
              //                 )),
              //
              //
              //
              //           ],
              //         ),
              //       );
              //     });
            },
          ),
        ),
            IconButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateOfferletter(
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
            //        _con!.deleteOfferLetterandExp(widget.id!, context);
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
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                        //controller: _con!.screenshotController,
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Align(
                            //     alignment: AlignmentDirectional.topEnd,
                            //     child: Text("${_con!.userData!.joiningDate}.")),
                            Center(
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 70,
                                    backgroundImage:  _con?.userData?.employerId?.profilePic?.isEmpty??true?
                                    AssetImage('assets/images/logo.png') as ImageProvider<Object>:
                                    NetworkImage(_con!.userData!.employerId!.profilePic!),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                      '${_con!
                                          .userData!.employerId!.businessName??"company Name"}',
                                    //'Manago',
                                    style: const TextStyle(color: const Color(0xff1E3852),fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${_con!
                                        .userData!.employerId!.businessAddress??"company Address"}',
                                    //'Manago',
                                    style: const TextStyle(color: const Color(0xff1E3852),fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${_con!
                                        .userData!.employerId!.businessCity??"city"}, ${_con!
                                         .userData!.employerId!.businessState?.toLowerCase()??"state"},',
                                       // ' ${_con! .userData!.employerId!.pincode??"pincode"} ',
                                    //'Manago',
                                    style: const TextStyle(color: const Color(0xff1E3852),fontSize: 15),
                                  ),
                                  // Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            SizedBox(height: 6),
                            Center(
                              child: Text(
                                "Letter of Appointment",
                                style: TextStyle(
                                    color:const Color(0xff1E3852),fontWeight: FontWeight.bold,fontSize: 23
                                ),
                              ),

                            ),
                            SizedBox(height: 10,),
                            Text(
                              '${_con!
                                  .userData!.candidateId!.personalInfo!.name}',
                              //'Manago',
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            Text(
                              '${_con!
                                  .userData!.candidateId!.personalInfo!.address??'Address'}',
                              //'Manago',
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            Text(
                              '${_con!
                                  .userData!.candidateId!.personalInfo!.city??"city"}, ${_con!
                                  .userData!.candidateId!.personalInfo!.state?.toLowerCase()??"state"},${_con!
                                  .userData!.candidateId!.personalInfo!.pinCode??"pincode"} ',
                              //'Manago',
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              1.2),
                                  child: RichText(

                                      text: TextSpan(
                                          text:
                                              "Dear ",
                                          style: TextStyle(color: kPrimaryColor, fontSize: 14,fontFamily: 'Jost'),
                                          children: [
                                        TextSpan(
                                          text: "${_con!
                                              .userData!.candidateId!.personalInfo!.name},\n",
                                            style: TextStyle(color: kPrimaryColor, fontSize: 14),
                                        ),
                                            TextSpan(
                                              text: "",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                                            ),



                                            TextSpan(
                                            text:
                                                "We are pleased to offer you the position of ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kPrimaryColor,

                                            fontWeight: FontWeight.normal, // Example: Set bold font weight
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${_con!.userData!.designation}",
                                          style: TextStyle(

                                              fontStyle: FontStyle.normal,
                                              color: kPrimaryColor,
                                              //fontWeight: FontWeight.bold

                                          ),
                                        ),
                                            TextSpan(
                                                text:
                                                " at ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:kPrimaryColor)),
                                            TextSpan(
                                              text: "${_con!
                                                  .userData!.employerId!.businessName}.",
                                              style: TextStyle(

                                                  fontStyle: FontStyle.normal,
                                                  color: kPrimaryColor,
                                                  //fontWeight: FontWeight.bold

                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                "We believe that your skills and experience make you an excellent fit for our team.\n\n",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:kPrimaryColor)),

                                            TextSpan(
                                                text:
                                                "Terms of Employment:",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            TextSpan(
                                                text:
                                                "\n - Position: ",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                                      TextSpan(
                                          text: "${_con!.userData!.designation}.",
                                        style: TextStyle(

                                            fontStyle: FontStyle.normal,
                                            color: kPrimaryColor,
                                            //fontWeight: FontWeight.bold

                                        ),),
                                            TextSpan(
                                                text:
                                                "\n - Start Date:  ",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                                            TextSpan(
                                              text: "${_con!.userData!.joiningDate}.",
                                                style: TextStyle(

                                                    fontStyle: FontStyle.normal,
                                                    color: kPrimaryColor,
                                                    //fontWeight: FontWeight.bold// Example: Set italic font style

                                                ),),
                                            TextSpan(
                                                text:
                                                "\n - Salary:  ",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                                            TextSpan(
                                              text: "₹ "+"${_con!.userData!.offeredSalary} Per Anum. \n\n",
                                                style: TextStyle(

                                                    fontStyle: FontStyle.normal,
                                                    color: kPrimaryColor,
                                                   // fontWeight: FontWeight.bold// Example: Set italic font style

                                                ),),
                                            WidgetSpan(child: SizedBox(height: 20,)),
                                            TextSpan(
                                                text:
                                                "We are excited about the prospect of you joining our team and contributing to our company\'s success. Please review this offer letter carefully, and if you have any questions or concerns, feel free to contact us.\n",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                                            TextSpan(
                                                text:
                                                "\nTo accept this offer, please sign and return a copy of this letter by ",
                                              style: TextStyle(color: kPrimaryColor, fontSize: 14),),
                                            TextSpan(
                                              text: "${_con!.userData!.joiningDate}.",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold,
                                                  color: kPrimaryColor),),



                                      ])),
                                ),
                              ],
                            ),






                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Sincerely,',
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${_con!
                                  .userData!.employerId!.businessName??"company Name"}',
                              //_con!.userData!.employerId!.name!,
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'HR',
                              style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            Text(
                              _con!.userData!.employerId!.email!,
                                style: TextStyle(color: kPrimaryColor, fontSize: 14),
                            ),
                            SizedBox(
                              height: 24,
                            ),
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
                          //     style:
                          //         TextStyle(fontSize: 16, color: Colors.white),
                          //   ),
                          //   onPressed: () {
                          //     print(widget.id);
                          //     print(_con!.userData!.id);
                          //
                          //     _launchPDFDownloadURL('http://apimanago2.v3red.com/document/downloadOfferLetter/${widget.id}');
                          //     //_con!.getPdf();
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
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                onPressed: () {
                                 Navigator.pop(context);

                                  //_con!.getPdf();
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            onPressed: () {
                              _sharePdf(
                                  'http://apimanago2.v3red.com/document/downloadOfferLetter/${widget.id}');
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
      final file = File('${tempDir.path}/Offer_Letter.pdf');

      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      await Share.shareFiles([file.path], text: 'salary_slip');
    } catch (e) {
      print('Error sharing salary slip: $e');
    }
  }






}
