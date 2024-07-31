import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:http/http.dart' as http;

import '../models/ApplicationDetailProfileViewModel.dart';

class ApplicationAgainstJobService {
  static BuildContext? context;
  static Future<ApplicantDetailsModel?>applicationAgainstJob(
      String api,GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      //   Map<String, String> header = {
      //     HttpHeaders.authorizationHeader: 'token $token'
      //   };
        final response = await http.get(Uri.parse(api));
        print(api);
        print("application against job status code ${response.statusCode}");
       // print(response.body);

        if (response.statusCode == 200) {


          final jsonResponse = applicantionAgainstEmployerModelFromJson((response.body));
          print("decode ${(response.body)}");

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
         print("application against job ERROR ${errorMessage}");
         Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   EasyLoading.dismiss();
      //
      //   Alert.showSnackbar('Connection timed out!', context!);
      //   return null;
      // } catch (e) {
      //   EasyLoading.dismiss();
      //
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context!);
    }
  }








  static Future profilecompletion(
      String api,GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      //   Map<String, String> header = {
      //     HttpHeaders.authorizationHeader: 'token $token'
      //   };
      final response = await http.get(Uri.parse(api));
      print(api);
      print("profile checking ...___> ${response.statusCode}");
      // print(response.body);

      if (response.statusCode == 200) {

     final jsonres=jsonDecode(response.body);
        //final jsonResponse = applicantionAgainstEmployerModelFromJson((response.body));
        print("decode ${(response.body)}");

        return jsonres["message"];
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['errorMessage'], context!);
        return null;
      } else {
        Map<String, dynamic> errorMessage = jsonDecode(response.body);
        print("application against job ERROR ${errorMessage}");
        Alert.showSnackbar(errorMessage['message'], context!);
        return null;
      }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   EasyLoading.dismiss();
      //
      //   Alert.showSnackbar('Connection timed out!', context!);
      //   return null;
      // } catch (e) {
      //   EasyLoading.dismiss();
      //
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context!);
    }
  }

  static Future<ApplicantDetailsProfileViewModel?>applicationProfileView(
      String api,GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      //   Map<String, String> header = {
      //     HttpHeaders.authorizationHeader: 'token $token'
      //   };
      final response = await http.get(Uri.parse(api));
      print(api);
      print("application profile view details status code ${response.statusCode}");
      // print(response.body);

      if (response.statusCode == 200) {


        final jsonResponse = applicantProfileViewModelFromJson((response.body));
        print("decode ${(response.body)}");

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['errorMessage'], context!);
        return null;
      } else {
        Map<String, dynamic> errorMessage = jsonDecode(response.body);
        print("application against job ERROR ${errorMessage}");
        Alert.showSnackbar(errorMessage['message'], context!);
        return null;
      }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   EasyLoading.dismiss();
      //
      //   Alert.showSnackbar('Connection timed out!', context!);
      //   return null;
      // } catch (e) {
      //   EasyLoading.dismiss();
      //
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context!);
    }
  }






}
