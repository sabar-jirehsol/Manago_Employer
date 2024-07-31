import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/Update_salary_model.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';

import '../models/DeleteSalaryModel.dart';

class UpdateSalaryServices {
  static BuildContext? context;
  static Future<UpdateSalaryModel?> updateSalaryService(
      String api,
      String salarySlipId,
      String salaryMonth,
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
         // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body = jsonEncode({
          "id": salarySlipId,
          "salaryMonth": salaryMonth,
          "employeeName": employeeName,
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
           print("Salary UPdating process AAPI ${api}");
           print(body);
        final response =
            await http.post(Uri.parse(api), headers: header, body: body);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          UpdateSalaryModel jsonResponse =
              updateSalaryModelFromJson(response.body);
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










   // static Future<DeleteSalaryModel?> deleteSalaryServices(
   //         String api,
   //         String employeeId,
   //     GlobalKey<ScaffoldState> scaffoldkey) async{
   //   var connectivityResult =
   //   await Connection.sharedInstance.checkConnectivity();
   //   if (connectivityResult == ConnectivityResult.mobile ||
   //       connectivityResult == ConnectivityResult.wifi) {
   //     try {
   //       Map<String, String> header = {
   //         // HttpHeaders.authorizationHeader: 'token $token',
   //         HttpHeaders.contentTypeHeader: 'application/json'
   //       };
   //
   //       final body=jsonEncode({
   //         "employeeID": employeeId,
   //
   //       });
   //       print("Salary Slip Deleted ${api}");
   //       print(body);
   //       final response=await http.post(Uri.parse(api),headers:header,body:body);
   //       print(response.statusCode);
   //       if (response.statusCode == 200) {
   //         DeleteSalaryModel jsonResponse =
   //         deleteSalaryModelFromJson(response.body);
   //         return jsonResponse;
   //       } else if (response.statusCode == 401) {
   //         final erroMessage = jsonDecode(response.body);
   //         Alert.showSnackbar(erroMessage['errorMessage'], context!);
   //         return null;
   //       } else {
   //         Map<String, dynamic> errorMessage = jsonDecode(response.body);
   //         Alert.showSnackbar(errorMessage['message'], context!);
   //         return null;
   //       }
   //     } on SocketException catch (e) {
   //       print(e.toString());
   //       Alert.showSnackbar('Connection timed out!', context!);
   //       return null;
   //     } catch (e) {
   //       e.toString();
   //       Alert.showSnackbar(e.toString(), context!);
   //       return null;
   //     }
   //   } else {
   //     Alert.showSnackbar('No Internet', context!);
   //     return null;
   //   }
   // }

















}
