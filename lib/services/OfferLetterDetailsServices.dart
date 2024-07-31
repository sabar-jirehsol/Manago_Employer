import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/OfferLetterDetailsModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class OfferLetterDetailsServices {

  static BuildContext? context;

  static Future<OfferLetterDetailsModel?> offerLetterDetailsService(
      String api,  GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
         // HttpHeaders.authorizationHeader: 'token $token'
        };
        print("OFFER LETTER");
        print(api);
        final response = await http.get(Uri.parse(api));
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          OfferLetterDetailsModel jsonResponse =
              offerLetterDetailsModelFromJson(response.body);
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
        Alert.showSnackbar('Connection time out!', context!);
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
