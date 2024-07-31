import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddOfferLetterModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/AddOfferLetter.dart';

import '../utils/success_dialogbox.dart';

class AddOfferLetterServices {
  static BuildContext? context;
  static Future<AddOfferLetterModel?> addOfferLetterService(
      String api,
      String employerId,
      String applicationId,
      String candidateId,
      String joiningDate,
      // int offeredSalary,
  String offeredSalary,
      String designation,
      String description,
      String createdBy,
     // String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
         // HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body =({
          "employerID": employerId,
          "applicationID": applicationId,
          "candidateID": candidateId,
          "documentType": "Offer Letter",
          "joiningDate": joiningDate,
          "offeredSalary": offeredSalary,
          "designation": designation,
          "description": description,
          "createdBy": createdBy,
          "modifiedBy": createdBy
        });
        print("API is ${api}");

          print("Offer letter body ${body}");
        final response =
            await http.post(Uri.parse(api), body: body);
          print(response.body);
          print("Status code");
        print(response.statusCode);
        if (response.statusCode == 200) {
          AddOfferLetterModel jsonResponse =
              addOfferLetterModelFromJson(response.body);
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          Alert.showSnackbar(erroMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          //Alert.showSnackbar(errorMessage['message'], context!);
          print("SHOWWWDIALOGGG");
          // showDialog(
          //   context: context!,
          //   barrierDismissible: false,
          //   builder: (context) {
          //     return WillPopScope(
          //       onWillPop: () async => false,
          //       child: StatefulBuilder(
          //         builder: (context, setState) {
          //           return FunkyOverlay(
          //               imagePath: 'assets/images/exc_mark.png',
          //               message: 'The offer letter has already been given successfully.',
          //               onTap: () {
          //                 Navigator.pop(context);
          //               }
          //           );
          //         },
          //       ),
          //     );
          //   },
          // );
          // Fluttertoast.showToast(msg: errorMessage['message'],
          //     timeInSecForIosWeb: 5,
          //     gravity:ToastGravity.BOTTOM,
          //     backgroundColor: Colors.white,
          //     textColor: Colors.red
          // );


          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } catch (e) {
        e.toString();
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }
}
