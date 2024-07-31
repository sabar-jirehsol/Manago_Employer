import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddJobModel.dart';
import 'package:manago_employer/models/AddSalaryModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';

class AddSalaryServices {
  static BuildContext? context;
  static Future<AddSalaryModel?> addSalaryService(
      String api,
      String salaryMonth,
      String salaryYear,
      String employeeName,
      String basic,
      String houseRentAllowance,
      String conveyance,
      String specialAllowance,
      String mobile,
      String providentFund,
      String professionalTax,
      String loan,
      String employerId,
      String employeeId,
      String candidateId,
      String createdBy,
      //String token,
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
        // Split the string based on the hyphen
        List<String> emp = employeeName.split("-");

        final body =jsonEncode({
          "salaryMonth": salaryMonth,
          "salaryYear":salaryYear,
          "employeeName": emp.first,
          "Earning": {
            "basic": basic,
            "houseRentAllowance": houseRentAllowance,
            "Conveyance": conveyance,
            "specialAllowance": specialAllowance,
            "mobile": mobile
          },
          "Deductions": {
            "providentFundDeduction": providentFund,
            "professionalTax": professionalTax,
            "Loan": loan
          },
          "employerID": employerId,
          "employeeID": employeeId,
          "candidateID": candidateId,
          "createdBy": createdBy,
          "modifiedBy": createdBy
        });
          print(body);
        final response =
            await http.post(Uri.parse(api), headers: header, body: body);
        print("SALARY CREATED:::");
        print(response.body);

        if (response.statusCode == 200) {
          AddSalaryModel jsonResponse = addSalaryModelFromJson(response.body);
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          Alert.showSnackbar(erroMessage['errorMessage'], context!);
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
