import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/UpdateApplicationStatusModel.dart';
import 'package:manago_employer/models/UpdateEmployeeStatusModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';

class UpdateStatusService {
  static Future<UpdateApplicationStatus?> updateApplicationStatus(
      String api,
      String id,
      String status,
      // String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final body = jsonEncode({"id": id, "status": status});

        final response = await http.put(
            Uri.parse(api), headers: header, body: body);
        print("STATUS::::");

        print(response.statusCode);
        print("STATUS::::");
        print(response.body);
        if (response.statusCode == 200) {
          UpdateApplicationStatus jsonResponse =
          updateApplicationStatusFromJson(response.body);
          print("staus jsonResponse");
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Fluttertoast.showToast(msg: errorMessage['errorMessage']);

          // SimpleDialog(title: Text(errorMessage['errorMessage']));

          //   Alert.showSnackbar(errorMessage['errorMessage'], scaffoldKey);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(errorMessage['error']['message']));
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        SimpleDialog(title: Text('Connection timed out!'));
        return null;
      } catch (e) {
        e.toString();
        SimpleDialog(title: Text(e.toString()));
        return null;
      }
    } else {
      SimpleDialog(title: Text('No Internet'));
      return null;
    }
  }








  static Future<UpdateEmployeeStatus?> updateEmployeeStatus(String api,
      String id,
      String status,
      String token,
      String jobID,
      String candidateID,
      String employerID,
      String offeredBasicSalary,
      String offeredGrossSalary,
      String designation,
      String note,
      String joiningDate,
      String createdBy,
      String modifiedBy,) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final body = jsonEncode({
          "id": id,
          "jobID": jobID,
          "candidateID": candidateID,
          "employerID": employerID,
          "OfferedBasicSalary": offeredBasicSalary,
          "OfferedGrossSalary": offeredGrossSalary,
          "Designation": designation,
          "Note": note,
          "status": status,
          "JoiningDate": joiningDate,
          "createdBy": createdBy,
          "modifiedBy": modifiedBy,
        });

        final response =
        await http.post(Uri.parse(api), headers: header, body: body);
        print(response.statusCode);
        if (response.statusCode == 200) {
          UpdateEmployeeStatus jsonResponse =
          updateEmployeeStatusFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(erroMessage['errorMessage']));
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(errorMessage['error']['message']));
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        SimpleDialog(title: Text('Connection timed out!'));
        return null;
      } catch (e) {
        e.toString();
        SimpleDialog(title: Text(e.toString()));
        return null;
      }
    } else {
      SimpleDialog(title: Text('No Internet'));
      return null;
    }
  }
}
