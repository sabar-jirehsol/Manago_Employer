import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/OtpVerificationModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class OtpVerificationServices {
  static BuildContext? context;
  static Future<OtpVerificationModel?> otpVerify(String api, String otp,
      String mobile, GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> body = {'otp': otp, 'mobile': mobile};
        // Map<String, String> header = {
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };

        final response = await http.post(Uri.parse(API.verifyOTP), body: body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          OtpVerificationModel jsonResponse =
              otpVerificationModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(errorMessage['error']['message']));
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out', context!);
        return null;
      } catch (e) {
        print((e.toString()));
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }




  static Future<OtpVerificationModel?> otpEmailVerify(
      String api,
      String email,
     String userRole,
      String otp,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> body = {'email': email,'userRole': userRole,'otp': otp};
        // Map<String, String> header = {
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        print("EMAIL OTP VERIFICATION");
         print(body);
        final response = await http.post(Uri.parse(API.verifyEmailOTP), body: body);
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          OtpVerificationModel jsonResponse =
          otpVerificationModelFromJson(response.body);

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          print("ERRRRR");
          print(errorMessage['error']);
          Alert.showSnackbar(errorMessage['error'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(errorMessage['error']));
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out', context!);
        return null;
      } catch (e) {
        print((e.toString()));
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }





}
