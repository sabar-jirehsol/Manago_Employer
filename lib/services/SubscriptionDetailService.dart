import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class SubscriptionDetailservice {
  static BuildContext? context;
  static Future<SubscriptionModel?> getsubscriptionDetails(
      String api,  GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
        };

        final response = await http.get(Uri.parse(api), headers: header);
        print("SUBSCRIPTION DETAIL PLANS::::");
        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          SubscriptionModel jsonResponse =
              subscriptionModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['error']['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out', context!);
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
