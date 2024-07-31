import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/ResendOtpModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class ResendOtpServices {
  static BuildContext? context;
  static Future<ResendOtpModel?> otpResend(String api, String id, String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> body = {'id': id};
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token'
        };

        final response =
            await http.post(Uri.parse(api), body: body, headers: header);
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          ResendOtpModel jsonResponse = resendOtpModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
    }
  }
}
