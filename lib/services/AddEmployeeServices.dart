import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddEmployeeModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class AddEmployeeServices {
  static BuildContext? context;
  static Future<AddEmployeeModel?> addEmployee(
      String api,
      String candidateId,
      String employerId,
      String jobId,
      String offeredBasicSalary,
      // int offeredBasicSalary,
      //int offeredGrossSalary,
      String designation,
      String note,
      String joiningDate,
      String createdBy,
      String modifiedBy,
      //String token,
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
        final body = jsonEncode({
          "jobID": jobId,
          "candidateID": candidateId,
          "employerID": employerId,
          "OfferedBasicSalary": offeredBasicSalary,
          //"OfferedGrossSalary": offeredGrossSalary,
          "Designation": designation,
          "Note": note,
          "JoiningDate": joiningDate,
          "createdBy": createdBy,
          "modifiedBy": modifiedBy
        });

        final response = await http.post(Uri.parse(api), headers: header, body: body);
        print(body);
        print("OFFER LETTER PROCESS");
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          AddEmployeeModel jsonResponse =
              addEmployeeModelFromJson(response.body);
          print("JSON RESPONSE");
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          Alert.showSnackbar(erroMessage['errorMessage'], context!);
          return null;
        } else if (response.statusCode == 404) {
          final erroMessage = jsonDecode(response.body);
          // final errorMessage = erroMessage['message'];

          Alert.showSnackbar(erroMessage['message'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } catch (e) {
        print(e.toString());
        return null;
        // Alert.showSnackbar(e.toString(), context!);
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }
}
