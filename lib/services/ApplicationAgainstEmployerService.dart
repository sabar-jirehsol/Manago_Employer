import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:http/http.dart' as http;

class ApplicationAgainstEmployerService {
  static BuildContext? context;
  static Future<ApplicantDetailsModel?> applicationAgainstEmployer(

      String api,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      //   Map<String, String> header = {
      //     HttpHeaders.authorizationHeader: 'token $token'
      //   };
      print(api);
        final response = await http.get(Uri.parse(api));

        // print(response.statusCode);
        print('Application against employer ${response.statusCode}');
        print(api);
        //print(response.body);

        if (response.statusCode == 200) {
          final jsonResponse =
              applicantionAgainstEmployerModelFromJson(response.body);
              return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Connection timed out!', context!);
      //   return null;
      // } on NoSuchMethodError catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Null exception', context!);
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
