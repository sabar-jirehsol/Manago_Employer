import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/OfferLetterDetailsModel.dart';
import 'package:manago_employer/services/OfferLetterDetailsServices.dart';
import 'package:manago_employer/utils/alert.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/OfferLetterListModel.dart';
import '../services/DeleteOfferLetterServices.dart';
import '../services/OfferLetterListServices.dart';
import '../services/UpdateOfferLetterStatusService.dart';
import '../utils/success_dialogbox.dart';
import '../views/bottom_navigation/applicants/offer_details.dart';
import '../views/bottom_navigation/applicants/offer_letters.dart';

class OfferLetterDetailsController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //ScreenshotController screenshotController = ScreenshotController();
  String? radiovalue="Offered";
  String? candidateIds;//Todo 2.4.24 i added i think change as employeed Id to pass then only it will reach Active Employee

  OfferLetterDatum? userData;

  offerLetterDetails(String id) async {
    //EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    // mobileNumber = _prefs.getString('mobile');

    print("offerdetails id ${id}");
    OfferLetterDetailsServices.offerLetterDetailsService(
            '${API.offerLetterDetails}/$id', scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        print(value.message);
        //userData = value.data![0];
        userData = value.data![0];
        print("emp<--->id");
        print(value.data![0].employeeId);
        print(value.data![0].designation);
        print(value.data![0].employerId?.profilePic);
        setState(() {});
      }
    });
  }

  File? pdfFile;
  BuildContext? context;
  // Future getPdf() async {
  //
  //   EasyLoading.show(status: 'Saving...');
  //   final _imageFile =
  //       await screenshotController.capture(delay: Duration(milliseconds: 10));
  //   pw.Document pdf = pw.Document();
  //   // for (var img in _image) {
  //   final image = pw.MemoryImage(_imageFile!);
  //
  //   pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a3,
  //       build: (pw.Context contex) {
  //         return pw.Center(child: pw.Image(image));
  //       }));
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     //add more permission to request here.
  //   ].request();
  //   EasyLoading.dismiss();
  //   if (statuses[Permission.storage]!.isGranted) {
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     if (dir != null) {
  //       // String savename = "file.pdf";
  //       // String savePath = dir.path + "/$savename";
  //       // print(savePath);
  //       var timestamp = DateTime.now().microsecond;
  //       pdfFile = File('${dir.path}/resume-${timestamp}.pdf');
  //       await pdfFile!.writeAsBytes(await pdf.save());
  //       Alert.showSnackbar("Saved!", context!);
  //
  //     }
  //   } else {
  //     Alert.showSnackbar(
  //         "No permission to read and write storage!", context!);
  //     print("No permission to read and write.");
  //   }
  // }
  //
  // sharePdf() async {
  //   EasyLoading.show(status: 'Saving...');
  //   final _imageFile =
  //       await screenshotController.capture(delay: Duration(milliseconds: 10));
  //   pw.Document pdf = pw.Document();
  //   // for (var img in _image) {
  //   final image = pw.MemoryImage(_imageFile!);
  //
  //   pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a3,
  //       build: (pw.Context contex) {
  //         return pw.Center(child: pw.Image(image));
  //       }));
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     //add more permission to request here.
  //   ].request();
  //   EasyLoading.dismiss();
  //   if (statuses[Permission.storage]!.isGranted) {
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     if (dir != null) {
  //       var timestamp = DateTime.now().microsecond;
  //       pdfFile = File('${dir.path}/resume-${timestamp}.pdf');
  //       await pdfFile!.writeAsBytes(await pdf.save());
  //       Share.shareFiles(
  //         [pdfFile!.path],
  //         subject: 'Share Resume',
  //       );
  //     }
  //     Alert.showSnackbar("Downloaded!",context!);
  //   } else {
  //     Alert.showSnackbar(
  //         "No permission to read and write storage!", context!);
  //     print("No permission to read and write.");
  //   }
  // }


  updateOfferLetterStatus(BuildContext context, String id, String status,
      ) async {
    if (status == null || status.isEmpty) {
    } else {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      //String? _token = _prefs.getString('token');
      UpdateOfferletterStatusService.updateOfferletterStatus(
          API.updateOfferLetterStatus, id, status,scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {//todo i changed   3.4.24 != null to null
          print("VALLLUUEE${value}");

          //getApplicantsAgainstJob(id);
          // setState(() {
          //   radiovalue = status;
          // });
          // status == 'Offer'
          //     ? Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OfferDetails(
          //           // id: id,
          //           // candidateId: candidateId,
          //         )))
          //     : Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    }
  }



  deleteOfferLetterandExp(String id, BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    //EasyLoading.show(status: 'Please wait...');
    print("Sending Delete ID ${id}");
    DeleteOfferLetterService.deleteOfferLetter("${API.deleteOfferletter}/$id",scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {


        //EasyLoading.showSuccess('Document Deleted',duration: Duration(seconds: 1));
       // Alert.showSnackbar('Experience Letter Deleted', context);

          Navigator.of(context).pop(context);
        Navigator.of(context).pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                        imagePath: 'assets/images/delframe.png',
                        message:'Document Deleted successfully' ,
                        text_color: Colors.red,
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
    });
  }










}
