import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';
import 'package:manago_employer/services/CandidateDetailsServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResumeController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //ScreenshotController screenshotController = ScreenshotController();

  CandidateData? userData;

  String? resumePath;
  BuildContext? context;

  // Future getPdf() async {
  //  // EasyLoading.show(status: 'Saving...');
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
  //
  //   EasyLoading.dismiss();
  //   if (statuses[Permission.storage]!.isGranted) {
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     if (dir != null) {
  //       // String savename = "file.pdf";
  //       // String savePath = dir.path + "/$savename";
  //       // print(savePath);
  //       var timestamp = DateTime.now().microsecond;
  //       final pdfFile = File('${dir.path}/resume-${timestamp}.pdf');
  //       await pdfFile.writeAsBytes(await pdf.save());
  //       Alert.showSnackbar("Saved!", context!);
  //     }
  //   } else {
  //     Alert.showSnackbar(
  //         "No permission to read and write storage!", context!);
  //     print("No permission to read and write.");
  //   }
  // }
  // {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   EasyLoading.show(status: 'Saving...');
  //   final _imageFile =
  //       await screenshotController.capture(delay: Duration(milliseconds: 10));
  //   pw.Document pdf = pw.Document();
  //   // for (var img in _image) {
  //   final image = pw.MemoryImage(_imageFile);

  //   pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context contex) {
  //         return pw.Center(child: pw.Image(image));
  //       }));
  //   // }
  //   try {
  //     // final dir = await getExternalStorageDirectory();
  //     String path = await ExtStorage.getExternalStoragePublicDirectory(
  //         ExtStorage.DIRECTORY_DOWNLOADS);

  //     final pdfFile = File('${path}/resume.pdf');
  //     await pdfFile.writeAsBytes(await pdf.save());
  //     EasyLoading.dismiss();
  //     Alert.showSnackbar("Saved!", scaffoldKey);
  //   } catch (e) {
  //     Alert.showSnackbar("Please try again.", scaffoldKey);
  //   }
  // }

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
  //
  //   EasyLoading.dismiss();
  //   if (statuses[Permission.storage]!.isGranted) {
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     if (dir != null) {
  //       var timestamp = DateTime.now().microsecond;
  //       final pdfFile = File('${dir.path}/resume-${timestamp}.pdf');
  //       await pdfFile.writeAsBytes(await pdf.save());
  //       Share.shareFiles(
  //         [pdfFile.path],
  //         subject: 'Share Resume',
  //       );
  //     }
  //   } else {
  //     Alert.showSnackbar(
  //         "No permission to read and write storage!", context!);
  //     print("No permission to read and write.");
  //   }
  // }

  // {
  //   // final directory = await getExternalStorageDirectory();
  //   String path = await ExtStorage.getExternalStoragePublicDirectory(
  //       ExtStorage.DIRECTORY_DOWNLOADS);
  //   Share.shareFiles(
  //     ['${path}/resume.pdf'],
  //     subject: 'Share Resume',
  //   );
  // }

  getCandidateDetails() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _id = _prefs.getString('candidateId');
    // mobileNumber = _prefs.getString('mobile');

    CandidateDetailsService.getCandidateDetails(
            '${API.getCandidateDetails}/$_id', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        userData = value.data;
        print(userData!.educationalInfo!.educationDetails!.length);

        setState(() {});
      }
    });
  }
}
