import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddExperienceLetterModal.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';

import '../utils/success_dialogbox.dart';

class AddExperienceLetterServices {
  static BuildContext? context;
  static Future<AddExperienceLetterModel?> addExperienceLetterService(
      String api,
      String employerId,
      String employeeId,
      String candidateId,
      String joiningDate,
      String relivingDate,
      //String offeredSalary,
      //int offeredSalary,
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
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body =jsonEncode({
          "employerID": employerId,
          "employeeID": employeeId,
          "candidateID": candidateId,
          "documentType": "Experience Letter",
          "joiningDate": joiningDate,
          "relivingDate": relivingDate,
          //"offeredSalary": offeredSalary,
          "designation": designation,
          "description": description,
          "createdBy": createdBy,
          "modifiedBy": createdBy
        });
        print("ADDING EXPEIRENCE ");
        print(body);
        print(api);
        final response =
            await http.post(Uri.parse(api), headers: header, body: body);
          print("ADDING EXPEIRENCE LETTER :");
          print(response.body);
        if (response.statusCode == 200) {
          AddExperienceLetterModel jsonResponse =
              addExperienceLetterModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          Alert.showSnackbar(erroMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
         // Alert.showSnackbar(errorMessage['message'], context!);
          Fluttertoast.showToast(msg: errorMessage['message'],
              timeInSecForIosWeb: 5,
              gravity:ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: Colors.red
          );

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
