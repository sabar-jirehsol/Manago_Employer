import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/models/EmployeeListModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

import '../models/ApplicantDetailModel.dart';
import '../models/OfferLetterListModel.dart';

class EmployeeListServices {
  static BuildContext? context;
  static Future<EmployeeListModel?> getEmployeeList(
      String api, GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
        Map<String, String> header = {
         // HttpHeaders.authorizationHeader: 'token $token'
        };
        final response = await http.get(Uri.parse(api));

        print("EMPLOYEE LIST DETAILS:");
        print(api);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {

          EmployeeListModel jsonResponse =
              employeeListModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Connection timmed out!', context!);
      //   return null;
      // } catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }












  static Future<ApplicantDetailsModel?> getApplicantsList(
      String api, GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      Map<String, String> header = {
        // HttpHeaders.authorizationHeader: 'token $token'
      };
      final response = await http.get(Uri.parse(api));

      print("Applicants LIST DETAILS:");
      print(api);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {

        ApplicantDetailsModel jsonResponse =
        applicantionAgainstEmployerModelFromJson(response.body);
        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['errorMessage'], context!);
        return null;
      } else {
        Map<String, dynamic> errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['message'], context!);
        return null;
      }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Connection timmed out!', context!);
      //   return null;
      // } catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }







}
