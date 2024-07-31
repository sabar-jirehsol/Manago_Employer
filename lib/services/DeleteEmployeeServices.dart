import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/DeleteEmployeeModel.dart';
import 'package:manago_employer/models/DeleteJobModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class DeleteEmployeeService {
  static BuildContext? context;
  static Future<EmployeeDeleteModel?> deleteEmployeeService(
      String api, String token, GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token'
        };
        final response = await http.delete(Uri.parse(api), headers: header);
        print(response.statusCode);

        if (response.statusCode == 200) {
          EmployeeDeleteModel jsonResponse =
              employeeDeleteModelFromJson(response.body);
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
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed Out', context!);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
    }
  }
}
