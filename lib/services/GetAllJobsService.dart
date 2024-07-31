import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/models/JobListModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/views/intro_screen/login_screen.dart';
import 'package:manago_employer/views/intro_screen/verification_screen.dart';

import '../main.dart';

class GetAllJobsServices {
  static BuildContext? context;
  static Future<JobListModel?>getAllJobss(String api,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // try {
      // print('token == $token');
      //   Map<String, String> header = {
      //     HttpHeaders.authorizationHeader: 'token $token',
      //   };

        final response = await http.get(Uri.parse(api),);
        print("job delete after fetch detaills");
        print(api);
        print(response.statusCode);
        print(response.body);
        print("Getting All jobs:");
        if (response.statusCode == 200) {
          JobListModel jsonResponse = jobListModelFromJson(response.body);

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);

          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else if (response.statusCode == 501) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
          return null;
        }

        {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context);
          return null;
        }
      // } on SocketException catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Connection timed out!', context!);
      //   return null;
      // } catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar(e.toString(), context!);
      //   return null;
      // }
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }
}
